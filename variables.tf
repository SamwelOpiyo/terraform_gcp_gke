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
  type        = "string"
  default     = 3
  description = "Number of nodes in each GKE cluster location."
}

variable "node_disk_size_gb" {
  type        = "string"
  default     = "100"
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

variable "gke_node_machine_type" {
  type        = "string"
  default     = "g1-small"
  description = "Machine type of GKE nodes"
}

variable "has_preemptible_nodes" {
  type        = "string"
  default     = "true"
  description = "Enable usage of preemptible nodes."
}

variable "gke_label_env" {
  type        = "string"
  default     = "dev"
  description = "environment"
}
