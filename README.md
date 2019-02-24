# Directory Description.

This repository contains terraform module used to create a Kubernetes cluster in Google Cloud Platform after provisioning Google Cloud Project.

## Module Environment Variables/Terraform Variables.

To assign variables check https://www.terraform.io/intro/getting-started/variables.html#assigning-variables.

The following variables must be set:

### Compulsory.

* project_name: Project Name or name to create the cluster in.
* project_id: Project ID or name to create the cluster in.
* client_email: Email of user/service account used to authenticate gcloud. This is used when retrieving kubeconfig file.
* cluster_name: Name of kubernetes cluster
* gke_master_password: password of master node of kubernetes cluster

### Non-Compulsory.

| Variable | Default Value | Description|
|---       |---            |---         |
| region | europe-west1 | GCP Project Region. |
| zone | europe-west1-b | GCP Project Zone. |
| service_account_iam_roles | `["roles/logging.logWriter", "roles/monitoring.metricWriter", "roles/viewer"]` | Permissions for Cluster Service Account. |
| kubernetes_logging_service | `logging.googleapis.com/kubernetes` | Logging service to use. |
| kubernetes_monitoring_service | `monitoring.googleapis.com/kubernetes` | Monitoring service to use. |
| cluster_zone | europe-west1-b | Region to launch servers. |
| cluster_description | GKE Kubernetes Cluster created by terraform. | Description of the cluster. |
| additional_cluster_zone | [] | Other zones in the same region to launch servers. |
| min_master_version | latest | GKE master version. |
| node_version | latest | GKE node version. |
| cluster_initial_node_count | 3 | Number of nodes in each GKE cluster zone. |
| node_disk_size_gb | 100 | Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. Defaults to 100GB. |
| node_disk_type | pd-standard | Type of the disk attached to each node (e.g. 'pd-standard' or 'pd-ssd'). If unspecified, the default disk type is 'pd-standard'. |
| gke_master_user | k8s_admin | Username to authenticate with the k8s master. |
| gke_node_machine_type | g1-small | Machine type of GKE nodes. |
| has_preemptible_nodes | true | Enable usage of preemptible nodes. |
| gke_label_env | dev | Environment label. |

## Module Outputs.

The following outputs are given:

| Output | Description|
|---     |---         |
| project_name | Project name specified. |
| project_id | Project ID specified. |
| region | Provider Region specified. |
| zone | Provider Zone specified. |
| google_service_account_cluster_service_account_email | The e-mail address of the service account. |
| google_service_account_cluster_service_account_unique_id | The unique id of the service account. |
| google_service_account_cluster_service_account_name | The fully-qualified name of the service account. |
| google_service_account_cluster_service_account_display_name | The display name for the service account. |
| google_service_account_cluster_service_account_key_name | The name of the service account key. |
| google_service_account_cluster_service_account_key_public_key | The public key, base64 encoded. |
| google_service_account_cluster_service_account_key_private_key | The private key in JSON format, base64 encoded. This is what you normally get as a file when creating service account keys through the CLI or web console. This is only populated when creating a new key, and when no pgp_key is provided. |
| google_service_account_cluster_service_account_key_valid_after | The key can be used after this timestamp. A timestamp in RFC3339 UTC `Zulu` format, accurate to nanoseconds. Example: `2014-10-02T15:01:23.045123456Z`. |
| google_service_account_cluster_service_account_key_valid_before | The key can be used before this timestamp. A timestamp in RFC3339 UTC `Zulu` format, accurate to nanoseconds. Example: `2014-10-02T15:01:23.045123456Z`. |
| google_container_cluster_name | The name of the cluster, unique within the project and zone. |
| google_container_cluster_zone | The zone that the master and the number of nodes specified in initial_node_count has been created in. |
| google_container_cluster_description | Description of the cluster. |
| google_container_cluster_additional_zones | The list of additional Google Compute Engine locations in which the cluster's nodes are located. If additional zones are configured, the number of nodes specified in initial_node_count has been created in each of the specified zones. |
| google_container_cluster_cluster_endpoint | Endpoint for accessing the master node. |
| google_container_cluster_client_certificate | Base64 encoded public certificate used by clients to authenticate to the cluster endpoint. |
| google_container_cluster_client_key | Base64 encoded private key used by clients to authenticate to the cluster endpoint. |
| google_container_cluster_cluster_ca_certificate | Base64 encoded public certificate that is the root of trust for the cluster. |
| google_container_cluster_cluster_ipv4_cidr | The IP address range of the kubernetes pods in the cluster. |
| google_container_cluster_cluster_autoscaling | Configuration for cluster autoscaling (also called autoprovisioning). |
| google_container_cluster_enable_kubernetes_alpha | Enable Kubernetes Alpha setting. If enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days. |
| google_container_cluster_enable_legacy_abac | Whether the ABAC authorizer is enabled for this cluster. When enabled, identities in the system, including service accounts, nodes, and controllers, will have statically granted permissions beyond those provided by the RBAC configuration or IAM. |
| google_container_cluster_initial_node_count | The number of nodes created in this cluster's default node pool (not including the Kubernetes master). |
| google_container_cluster_ip_allocation_policy | Configuration for cluster IP allocation. |
| google_container_cluster_logging_service | The logging service that the cluster writes logs to. |
| google_container_cluster_monitoring_service | The monitoring service that the cluster writes metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting. |
| google_container_cluster_maintenance_policy | The maintenance policy for the cluster. |
| google_container_cluster_master_auth | The authentication information for accessing the Kubernetes master. |
| google_container_cluster_master_authorized_networks_config | The desired configuration options for master authorized networks |
| google_container_cluster_min_master_version | The minimum version of the master. GKE will auto-update the master to new versions. |
| google_container_cluster_master_version | The version of the master. |
| google_container_cluster_network | The name or self_link of the Google Compute Engine network to which the cluster is connected. |
| google_container_cluster_network_policy | Configuration options for the NetworkPolicy feature. |
| google_container_cluster_node_config | Configuration options for the nodes. |
| google_container_cluster_node_pool | List of node pools associated with this cluster. Warning: node pools defined inside a cluster can't be changed (or added/removed) after cluster creation without deleting and recreating the entire cluster. Use the google_container_node_pool resource instead of this property during creation. |
| google_container_cluster_node_version | The Kubernetes version on the nodes. |
| google_container_cluster_private_cluster_config | Configurations for private cluster. |
| google_container_cluster_project | The ID of the project in which the resource belongs. |
| google_container_cluster_resource_labels | GCE resource labels (a map of key/value pairs) applied to the cluster. |
| google_container_cluster_subnetwork | The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances have been launched. |
| google_container_cluster_addons_config | The configurations for addons supported by GKE. |
| google_container_cluster_instance_group_urls | List of instance group URLs which have been assigned to the cluster. |
| google_container_cluster_tpu_ipv4_cidr_block | The IP address range of the Cloud TPUs in this cluster, in CIDR notation (e.g. 1.2.3.4/29). |

# Using the module in your project.

Call the module in your terraform script as follows:

## Create Variables block. (Just a sample, you can create it with all module variables. This illustration only uses the compulsory variables.)

```
variable "region" {
  type        = "string"
  default     = "europe-west1"
  description = "Google Provider Region."
}

variable "zone" {
  type        = "string"
  default     = "europe-west1-b"
  description = "Google Provider Zone."
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

variable "cluster_name" {
  type        = "string"
  description = "Desired name of GKE cluster"
}

variable "gke_master_password" {
  type        = "string"
  description = "Password to authenticate with the k8s master"
}
```

## Calling the module while setting variables using those defined in above block. (Remember to set the ref appropriately considering release features.)

```
module "terraform_gcp_gke" {
  source = "git::https://github.com/SamwelOpiyo/terraform_gcp_gke//?ref=v0.1.0"
  region       = "${var.region}"
  zone         = "${var.zone}"
  project_name = "${var.project_name}"
  project_id   = "${var.project_id}"

  cluster_name        = "${var.cluster_name}"
  gke_master_password = "${var.gke_master_password}"
  client_email        = "${var.client_email}"

  # cluster_description           = "${var.cluster_description}"
  # cluster_zone                  = "${var.cluster_zone}"
  # additional_cluster_zone       = "${var.additional_cluster_zone}"
  # min_master_version            = "${var.min_master_version}"
  # node_version                  = "${var.node_version}"
  # cluster_initial_node_count    = "${var.cluster_initial_node_count}"
  # node_disk_size_gb             = "${var.node_disk_size_gb}"
  # node_disk_type                = "${var.node_disk_type}"
  # gke_master_user               = "${var.gke_master_user}"
  # gke_node_machine_type         = "${var.gke_node_machine_type}"
  # has_preemptible_nodes         = "${var.has_preemptible_nodes}"
  # gke_label_env                 = "${var.gke_label_env}"
  # service_account_iam_roles     = "${var.service_account_iam_roles}"
  # kubernetes_logging_service    = "${var.kubernetes_logging_service}"
  # kubernetes_monitoring_service = "${var.kubernetes_monitoring_service}"
}
```

## Getting the outputs.

Sample outputs. You can include all outputs you require while referring to Module Outputs above for guidance.

```
output "terraform_gcp_gke_project_name" {
  value = "${module.terraform_gcp_gke.project_name}"
}

output "terraform_gcp_gke_project_id" {
  value = "${module.terraform_gcp_gke.project_id}"
}

output "google_container_cluster_project" {
  value       = "${module.terraform_gcp_gke.google_container_cluster_project}"
  description = "The ID of the project in which the resource belongs."
}

output "region" {
  value = "${module.terraform_gcp_gke.region}"
}

output "zone" {
  value = "${module.terraform_gcp_gke.zone}"
}

output "cluster_endpoint" {
  value       = "${module.terraform_gcp_gke.cluster_endpoint}"
  description = "Endpoint for accessing the master node."
}

output "client_certificate" {
  value = "${module.terraform_gcp_gke.client_certificate}"
}

output "client_key" {
  value = "${module.terraform_gcp_gke.client_key}"
}

output "cluster_ca_certificate" {
  value = "${module.terraform_gcp_gke.cluster_ca_certificate}"
}

output "google_container_cluster_node_config" {
  value       = "${module.terraform_gcp_gke.google_container_cluster_node_config}"
  description = "Configuration options for the nodes."
}

output "google_container_cluster_master_version" {
  value       = "${module.terraform_gcp_gke.google_container_cluster_master_version}"
  description = "The version of the master."
}

output "google_container_cluster_node_version" {
  value       = "${module.terraform_gcp_gke.google_container_cluster_node_version}"
  description = "The Kubernetes version on the nodes."
}

output "google_service_account_cluster_service_account_email" {
  value = "${module.terraform_gcp_gke.google_service_account_cluster_service_account_email}"
}

output "google_service_account_cluster_service_account_key_name" {
  value = "${module.terraform_gcp_gke.google_service_account_cluster_service_account_key_name}"
}

output "google_service_account_cluster_service_account_key_public_key" {
  value = "${module.terraform_gcp_gke.google_service_account_cluster_service_account_key_public_key}"
}

output "google_service_account_cluster_service_account_key_private_key" {
  value = "${module.terraform_gcp_gke.google_service_account_cluster_service_account_key_private_key}"
}

output "google_service_account_cluster_service_account_key_valid_after" {
  value = "${module.terraform_gcp_gke.google_service_account_cluster_service_account_key_valid_after}"
}

output "google_service_account_cluster_service_account_key_valid_before" {
  value = "${module.terraform_gcp_gke.google_service_account_cluster_service_account_key_valid_before}"
}
```
