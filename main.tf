provider "google-beta" {
  region  = "${var.region}"
  zone    = "${var.zone}"
  project = "${var.project_id}"
}

locals {
  resource_limits = "${var.is_cluster_autoscaling_enabled}" == true ? [
    {
      resource_type = "cpu"
      maximum       = "${var.cluster_autoscaling_cpu_max_limit}"
      minimum       = "${var.cluster_autoscaling_cpu_min_limit}"
    },
    {
      resource_type = "memory"
      maximum       = "${var.cluster_autoscaling_memory_max_limit}"
      minimum       = "${var.cluster_autoscaling_memory_min_limit}"
    },
  ] : []
}

# see https://www.terraform.io/docs/providers/google/r/container_cluster.html

data "google_container_engine_versions" "versions" {
  project = "${var.project_id}"
  region  = "${var.cluster_location}"

  depends_on = [
    "google_project_services.project-services",
  ]
}

resource "google_project_services" "project-services" {
  project            = "${var.project_id}"
  disable_on_destroy = "false"

  services = "${var.project_services_to_enable}"
}

resource "google_service_account" "cluster-service-account" {
  account_id   = "${var.project_name}-cluster-sa"
  display_name = "${var.project_name}-cluster-sa"
  project      = "${var.project_id}"

  depends_on = [
    "google_project_services.project-services",
  ]
}

resource "google_service_account_key" "cluster-service-account-key" {
  service_account_id = "${google_service_account.cluster-service-account.name}"
}

resource "google_project_iam_member" "service-account-cluster-service-account" {
  count   = "${length(var.service_account_iam_roles)}"
  project = "${var.project_id}"
  role    = "${element(var.service_account_iam_roles, count.index)}"
  member  = "serviceAccount:${google_service_account.cluster-service-account.email}"

  depends_on = [
    "google_service_account.cluster-service-account",
  ]
}

resource "google_container_cluster" "cluster" {
  provider = "google-beta"
  project  = "${var.project_id}"
  name     = "${var.cluster_name}"
  location = "${var.cluster_location}"

  description = "${var.cluster_description}"

  initial_node_count = "${var.cluster_initial_node_count}"

  min_master_version = "${var.min_master_version == "latest" ? data.google_container_engine_versions.versions.latest_master_version : var.min_master_version}"

  node_version = "${var.node_version == "latest" ? data.google_container_engine_versions.versions.latest_node_version : var.node_version}"

  node_locations = "${var.node_locations}"

  master_auth {
    username = "${var.gke_master_user}"
    password = "${var.gke_master_password}"
    client_certificate_config {
      issue_client_certificate = "${var.issue_client_certificate}"
    }
  }

  addons_config {
    http_load_balancing {
      disabled = "${var.is_http_load_balancing_disabled}"
    }

    horizontal_pod_autoscaling {
      disabled = "${var.is_horizontal_pod_autoscaling_disabled}"
    }

    kubernetes_dashboard {
      disabled = "${var.is_kubernetes_dashboard_disabled}"
    }

    istio_config {
      disabled = "${var.is_istio_disabled}"
      auth     = "AUTH_MUTUAL_TLS"
    }

    cloudrun_config {
      disabled = "${var.is_cloudrun_disabled}"
    }
  }

  vertical_pod_autoscaling {
    enabled = "${var.is_vertical_pod_autoscaling_enabled}"
  }

  cluster_autoscaling {
    enabled = "${var.is_cluster_autoscaling_enabled}"

    dynamic "resource_limits" {
      for_each = [for resource_limit in local.resource_limits : {
        resource_type = resource_limit.resource_type
        maximum       = resource_limit.maximum
        minimum       = resource_limit.minimum
      }]

      content {
        resource_type = resource_limits.value.resource_type
        maximum       = resource_limits.value.maximum
        minimum       = resource_limits.value.minimum
      }
    }

    # If cluster_autoscaling is enabled, the code above generates
    # resource_limits {
      # resource_type = "cpu"
      # maximum       = "${var.cluster_autoscaling_cpu_max_limit}"
      # minimum       = "${var.cluster_autoscaling_cpu_min_limit}"
    # }

    # resource_limits {
      # resource_type = "memory"
      # maximum       = "${var.cluster_autoscaling_memory_max_limit}"
      # minimum       = "${var.cluster_autoscaling_memory_min_limit}"
    # }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "${var.daily_maintenance_start_time}"
    }
  }

  logging_service    = "${var.kubernetes_logging_service}"
  monitoring_service = "${var.kubernetes_monitoring_service}"

  node_config {
    machine_type = "${var.gke_node_machine_type}"
    preemptible  = "${var.has_preemptible_nodes}"

    service_account = "${google_service_account.cluster-service-account.email}"

    oauth_scopes = "${var.cluster_oauth_scopes}"

    labels = {
      generator = "terraform"
      env       = "${var.gke_label_env}"
    }

    disk_size_gb = "${var.node_disk_size_gb}"
    disk_type    = "${var.node_disk_type}"

    tags = ["gke-node", "${var.cluster_name}"]
  }

  depends_on = [
    "google_project_iam_member.service-account-cluster-service-account",
  ]
}

resource "null_resource" "apply" {
  triggers = {
    host                   = "${md5(google_container_cluster.cluster.endpoint)}"
    username               = "${md5(google_container_cluster.cluster.master_auth.0.username)}"
    password               = "${md5(google_container_cluster.cluster.master_auth.0.password)}"
    client_certificate     = "${md5(google_container_cluster.cluster.master_auth.0.client_certificate)}"
    client_key             = "${md5(google_container_cluster.cluster.master_auth.0.client_key)}"
    cluster_ca_certificate = "${md5(google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)}"
  }

  provisioner "local-exec" {
    command = <<EOF
      gcloud container clusters get-credentials "${google_container_cluster.cluster.name}" --zone="${google_container_cluster.cluster.location}" --project="${var.project_id}"
      CONTEXT="gke_"${var.project_id}"_${google_container_cluster.cluster.location}_${google_container_cluster.cluster.name}" kubectl create clusterrolebinding myname-cluster-admin-binding --clusterrole=cluster-admin --user="${var.client_email}"
      EOF
  }
}
