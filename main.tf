provider "google" {
  region  = "${var.region}"
  zone    = "${var.zone}"
  project = "${var.project_id}"
}

# see https://www.terraform.io/docs/providers/google/r/container_cluster.html

data "google_container_engine_versions" "versions" {
  project = "${var.project_id}"
  zone    = "${var.zone}"
}

resource "google_service_account" "cluster-service-account" {
  account_id   = "${var.project_name}-cluster-sa"
  display_name = "${var.project_name}-cluster-sa"
  project      = "${var.project_id}"
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
  project = "${var.project_id}"
  name    = "${var.cluster_name}"
  zone    = "${var.cluster_zone}"

  description = "${var.cluster_description}"

  initial_node_count = "${var.cluster_initial_node_count}"

  min_master_version = "${var.min_master_version == "latest" ? data.google_container_engine_versions.versions.latest_master_version : var.min_master_version}"

  node_version = "${var.node_version == "latest" ? data.google_container_engine_versions.versions.latest_node_version : var.node_version}"

  additional_zones = "${var.additional_cluster_zone}"

  master_auth {
    username = "${var.gke_master_user}"
    password = "${var.gke_master_password}"
  }

  logging_service    = "${var.kubernetes_logging_service}"
  monitoring_service = "${var.kubernetes_monitoring_service}"

  node_config {
    machine_type = "${var.gke_node_machine_type}"
    preemptible  = "${var.has_preemptible_nodes}"

    service_account = "${google_service_account.cluster-service-account.email}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]

    labels {
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

provider "kubernetes" {
  host     = "${google_container_cluster.cluster.endpoint}"
  username = "${google_container_cluster.cluster.master_auth.0.username}"
  password = "${google_container_cluster.cluster.master_auth.0.password}"

  client_certificate     = "${base64decode(google_container_cluster.cluster.master_auth.0.client_certificate)}"
  client_key             = "${base64decode(google_container_cluster.cluster.master_auth.0.client_key)}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)}"
}

resource "null_resource" "apply" {
  triggers {
    host                   = "${md5(google_container_cluster.cluster.endpoint)}"
    username               = "${md5(google_container_cluster.cluster.master_auth.0.username)}"
    password               = "${md5(google_container_cluster.cluster.master_auth.0.password)}"
    client_certificate     = "${md5(google_container_cluster.cluster.master_auth.0.client_certificate)}"
    client_key             = "${md5(google_container_cluster.cluster.master_auth.0.client_key)}"
    cluster_ca_certificate = "${md5(google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)}"
  }

  provisioner "local-exec" {
    command = <<EOF
      gcloud container clusters get-credentials "${google_container_cluster.cluster.name}" --zone="${google_container_cluster.cluster.zone}" --project="${var.project_id}"
      CONTEXT="gke_"${var.project_id}"_${google_container_cluster.cluster.zone}_${google_container_cluster.cluster.name}" kubectl create clusterrolebinding myname-cluster-admin-binding --clusterrole=cluster-admin --user="${var.client_email}"
      EOF
  }
}
