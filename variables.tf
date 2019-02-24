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

variable "cluster_zone" {
  type        = "string"
  default     = "europe-west1-b"
  description = "GCP zone to launch servers"
}

variable "cluster_description" {
  type        = "string"
  default     = "GKE Kubernetes Cluster created by terraform."
  description = "Description of the cluster."
}

variable "additional_cluster_zone" {
  type        = "list"
  default     = []
  description = "Other zones in the same region to launch servers."
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
  description = "Number of nodes in each GKE cluster zone"
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
