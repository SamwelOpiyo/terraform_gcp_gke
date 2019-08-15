variable "region" {
  type        = "string"
  default     = "europe-west1"
  description = "GCP Project Region."
}

variable "zone" {
  type        = "string"
  default     = "europe-west1-b"
  description = "GCP Project Zone."
}

variable "project_name" {
  type = "string"
}

variable "project_id" {
  type = "string"
}

variable "client_email" {
  type = "string"
}

variable "project_services_to_enable" {
  type = "list"

  default = [
    "cloudresourcemanager.googleapis.com",
    "servicemanagement.googleapis.com",
    "serviceusage.googleapis.com",
    "storage-api.googleapis.com",
    "iam.googleapis.com",
    "oslogin.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "iamcredentials.googleapis.com",
    "bigquery-json.googleapis.com",
    "pubsub.googleapis.com",
  ]

  description = "Project Services to enable so that provisioning of resources will work through the API."
}

variable "service_account_iam_roles" {
  type = "list"

  default = [
    "roles/viewer",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
  ]

  description = "Permissions for Cluster Service Account."
}

variable "kubernetes_logging_service" {
  type        = "string"
  default     = "logging.googleapis.com/kubernetes"
  description = "Logging service to use."
}

variable "kubernetes_monitoring_service" {
  type        = "string"
  default     = "monitoring.googleapis.com/kubernetes"
  description = "Monitoring service to use."
}

variable "cluster_name" {
  type        = "string"
  description = "Desired name of GKE cluster."
}

variable "cluster_location" {
  type        = "string"
  default     = "europe-west1"
  description = "GCP location to launch servers. If a zone is specified (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If a region is specified (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well."
}

variable "cluster_description" {
  type        = "string"
  default     = "GKE Kubernetes Cluster created by terraform."
  description = "Description of the cluster."
}

variable "cluster_oauth_scopes" {
  type = "list"

  default = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/devstorage.read_only",
  ]

  description = "The set of Google API scopes to be made available on all of the node VMs under the 'default' service account."
}

variable "node_locations" {
  type        = "list"
  default     = []
  description = "Other locations to launch servers. These must be in the same region as the cluster zone for zonal clusters, or in the region of a regional cluster. In a multi-zonal cluster, the number of nodes specified in initial_node_count is created in all specified zones as well as the primary zone. If specified for a regional cluster, nodes will only be created in these zones."
}

variable "min_master_version" {
  type        = "string"
  default     = "latest"
  description = "GKE Master Version."
}

variable "node_version" {
  type        = "string"
  default     = "latest"
  description = "GKE Node Version."
}

variable "cluster_initial_node_count" {
  type        = number
  default     = 3
  description = "Number of nodes in each GKE cluster location."
}

variable "node_disk_size_gb" {
  type        = number
  default     = 100
  description = "Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. Defaults to 100GB."
}

variable "node_disk_type" {
  type        = "string"
  default     = "pd-standard"
  description = "Type of the disk attached to each node (e.g. 'pd-standard' or 'pd-ssd'). If unspecified, the default disk type is 'pd-standard'."
}

variable "gke_master_user" {
  type        = "string"
  default     = "k8s_admin"
  description = "Username to authenticate with the k8s master"
}

variable "gke_master_password" {
  type        = "string"
  description = "Password to authenticate with the k8s master"
}

variable "issue_client_certificate" {
  type        = bool
  default     = true
  description = "Issue client certificate for cluster."
}

variable "gke_node_machine_type" {
  type        = "string"
  default     = "g1-small"
  description = "Machine type of GKE nodes"
}

variable "has_preemptible_nodes" {
  type        = bool
  default     = true
  description = "Enable usage of preemptible nodes."
}

variable "gke_label_env" {
  type        = "string"
  default     = "dev"
  description = "environment"
}

variable "is_http_load_balancing_disabled" {
  type        = bool
  default     = false
  description = "Status of HTTP (L7) load balancing controller addon, which makes it easy to set up HTTP load balancers for services in a cluster."
}

variable "is_kubernetes_dashboard_disabled" {
  type        = bool
  default     = false
  description = "Status of the Kubernetes Dashboard add-on, which controls whether the Kubernetes Dashboard will be enabled for this cluster."
}

variable "is_horizontal_pod_autoscaling_disabled" {
  type        = bool
  default     = false
  description = "Status of the Horizontal Pod Autoscaling addon, which increases or decreases the number of replica pods a replication controller has based on the resource usage of the existing pods. It ensures that a Heapster pod is running in the cluster, which is also used by the Cloud Monitoring service."
}

variable "is_istio_disabled" {
  type        = bool
  default     = true
  description = "Status of the Istio addon."
}

variable "is_cloudrun_disabled" {
  type        = bool
  default     = true
  description = "Status of the CloudRun addon. It requires istio_config enabled."
}

variable "daily_maintenance_start_time" {
  type        = "string"
  default     = "12:00"
  description = "Time window specified for daily maintenance operations. Specify start_time in RFC3339 format 'HH:MM', where HH : [00-23] and MM : [00-59] GMT."
}

variable "is_vertical_pod_autoscaling_enabled" {
  type        = bool
  default     = false
  description = "Status of Vertical Pod Autoscaling. Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it."
}

variable "is_cluster_autoscaling_enabled" {
  type        = bool
  default     = false
  description = "Is node autoprovisioning enabled. To set this to true, make sure your config meets the rest of the requirements. Notably, you'll need min_master_version of at least 1.11.2."
}

variable "cluster_autoscaling_cpu_max_limit" {
  type        = number
  default     = 10
  description = "Maximum CPU limit for autoscaling if it is enabled."
}

variable "cluster_autoscaling_cpu_min_limit" {
  type        = number
  default     = 1
  description = "Minimum CPU limit for autoscaling if it is enabled."
}

variable "cluster_autoscaling_memory_max_limit" {
  type        = number
  default     = 64
  description = "Maximum memory limit for autoscaling if it is enabled."
}

variable "cluster_autoscaling_memory_min_limit" {
  type        = number
  default     = 2
  description = "Minimum memory limit for autoscaling if it is enabled."
}
