# GCP GKE outputs

output "project_name" {
  value = "${var.project_name}"
}

output "project_id" {
  value = "${var.project_id}"
}

output "region" {
  value = "${var.region}"
}

output "zone" {
  value = "${var.zone}"
}

output "google_service_account_cluster_service_account_email" {
  value       = "${google_service_account.cluster-service-account.email}"
  description = "The e-mail address of the service account."
}

output "google_service_account_cluster_service_account_unique_id" {
  value       = "${google_service_account.cluster-service-account.unique_id}"
  description = "The unique id of the service account."
}

output "google_service_account_cluster_service_account_name" {
  value       = "${google_service_account.cluster-service-account.name}"
  description = "The fully-qualified name of the service account."
}

output "google_service_account_cluster_service_account_display_name" {
  value       = "${google_service_account.cluster-service-account.display_name}"
  description = "The display name for the service account."
}

output "google_service_account_cluster_service_account_key_name" {
  value       = "${google_service_account_key.cluster-service-account-key.name}"
  description = "The name of the service account key."
}

output "google_service_account_cluster_service_account_key_public_key" {
  value       = "${google_service_account_key.cluster-service-account-key.public_key}"
  description = "The public key, base64 encoded."
}

output "google_service_account_cluster_service_account_key_private_key" {
  value       = "${google_service_account_key.cluster-service-account-key.private_key}"
  description = "The private key in JSON format, base64 encoded. This is what you normally get as a file when creating service account keys through the CLI or web console. This is only populated when creating a new key, and when no pgp_key is provided."
}

output "google_service_account_cluster_service_account_key_valid_after" {
  value       = "${google_service_account_key.cluster-service-account-key.valid_after}"
  description = "The key can be used after this timestamp. A timestamp in RFC3339 UTC 'Zulu' format, accurate to nanoseconds. Example: '2014-10-02T15:01:23.045123456Z'."
}

output "google_service_account_cluster_service_account_key_valid_before" {
  value       = "${google_service_account_key.cluster-service-account-key.valid_before}"
  description = "The key can be used before this timestamp. A timestamp in RFC3339 UTC 'Zulu' format, accurate to nanoseconds. Example: '2014-10-02T15:01:23.045123456Z'."
}

output "google_container_cluster_name" {
  value       = "${google_container_cluster.cluster.name}"
  description = "The name of the cluster, unique within the project and zone."
}

output "google_container_cluster_zone" {
  value       = "${google_container_cluster.cluster.zone}"
  description = "The zone that the master and the number of nodes specified in initial_node_count has been created in."
}

output "google_container_cluster_cluster_endpoint" {
  value       = "${google_container_cluster.cluster.endpoint}"
  description = "Endpoint for accessing the master node"
}

output "google_container_cluster_client_certificate" {
  value       = "${google_container_cluster.cluster.master_auth.0.client_certificate}"
  description = "Base64 encoded public certificate used by clients to authenticate to the cluster endpoint."
}

output "google_container_cluster_client_key" {
  value       = "${google_container_cluster.cluster.master_auth.0.client_key}"
  description = "Base64 encoded private key used by clients to authenticate to the cluster endpoint."
}

output "google_container_cluster_cluster_ca_certificate" {
  value       = "${google_container_cluster.cluster.master_auth.0.cluster_ca_certificate}"
  description = "Base64 encoded public certificate that is the root of trust for the cluster."
}

output "google_container_cluster_additional_zones" {
  value       = "${google_container_cluster.cluster.additional_zones}"
  description = "The list of additional Google Compute Engine locations in which the cluster's nodes are located. If additional zones are configured, the number of nodes specified in initial_node_count has been created in each of the specified zones."
}

output "google_container_cluster_cluster_ipv4_cidr" {
  value       = "${google_container_cluster.cluster.cluster_ipv4_cidr}"
  description = "The IP address range of the kubernetes pods in the cluster."
}

output "google_container_cluster_cluster_autoscaling" {
  value       = "${google_container_cluster.cluster.cluster_autoscaling}"
  description = "Configuration for cluster autoscaling (also called autoprovisioning)."
}

output "google_container_cluster_description" {
  value       = "${google_container_cluster.cluster.description}"
  description = "Description of the cluster."
}

output "google_container_cluster_enable_kubernetes_alpha" {
  value       = "${google_container_cluster.cluster.enable_kubernetes_alpha}"
  description = "Enable Kubernetes Alpha setting. If enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days."
}

output "google_container_cluster_enable_legacy_abac" {
  value       = "${google_container_cluster.cluster.enable_legacy_abac}"
  description = "Whether the ABAC authorizer is enabled for this cluster. When enabled, identities in the system, including service accounts, nodes, and controllers, will have statically granted permissions beyond those provided by the RBAC configuration or IAM."
}

output "google_container_cluster_initial_node_count" {
  value       = "${google_container_cluster.cluster.initial_node_count}"
  description = "The number of nodes created in this cluster's default node pool (not including the Kubernetes master)."
}

output "google_container_cluster_ip_allocation_policy" {
  value       = "${google_container_cluster.cluster.ip_allocation_policy}"
  description = "Configuration for cluster IP allocation."
}

output "google_container_cluster_logging_service" {
  value       = "${google_container_cluster.cluster.logging_service}"
  description = "The logging service that the cluster writes logs to."
}

output "google_container_cluster_monitoring_service" {
  value       = "${google_container_cluster.cluster.monitoring_service}"
  description = "The monitoring service that the cluster writes metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting."
}

output "google_container_cluster_maintenance_policy" {
  value       = "${google_container_cluster.cluster.maintenance_policy}"
  description = "The maintenance policy for the cluster."
}

output "google_container_cluster_master_auth" {
  value       = "${google_container_cluster.cluster.master_auth}"
  description = "The authentication information for accessing the Kubernetes master."
}

output "google_container_cluster_master_authorized_networks_config" {
  value       = "${google_container_cluster.cluster.master_authorized_networks_config}"
  description = "The desired configuration options for master authorized networks."
}

output "google_container_cluster_min_master_version" {
  value       = "${google_container_cluster.cluster.min_master_version}"
  description = "The minimum version of the master. GKE will auto-update the master to new versions."
}

output "google_container_cluster_master_version" {
  value       = "${google_container_cluster.cluster.master_version}"
  description = "The version of the master."
}

output "google_container_cluster_network" {
  value       = "${google_container_cluster.cluster.network}"
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected."
}

output "google_container_cluster_network_policy" {
  value       = "${google_container_cluster.cluster.network_policy}"
  description = "Configuration options for the NetworkPolicy feature."
}

output "google_container_cluster_node_config" {
  value       = "${google_container_cluster.cluster.node_config}"
  description = "Configuration options for the nodes."
}

output "google_container_cluster_node_pool" {
  value       = "${google_container_cluster.cluster.node_pool}"
  description = "List of node pools associated with this cluster. Warning: node pools defined inside a cluster can't be changed (or added/removed) after cluster creation without deleting and recreating the entire cluster. Use the google_container_node_pool resource instead of this property during creation."
}

output "google_container_cluster_node_version" {
  value       = "${google_container_cluster.cluster.node_version}"
  description = "The Kubernetes version on the nodes."
}

output "google_container_cluster_private_cluster_config" {
  value       = "${google_container_cluster.cluster.private_cluster_config}"
  description = "Configurations for private cluster."
}

output "google_container_cluster_project" {
  value       = "${google_container_cluster.cluster.project}"
  description = "The ID of the project in which the resource belongs."
}

output "google_container_cluster_resource_labels" {
  value       = "${google_container_cluster.cluster.resource_labels}"
  description = "GCE resource labels (a map of key/value pairs) applied to the cluster."
}

output "google_container_cluster_subnetwork" {
  value       = "${google_container_cluster.cluster.subnetwork}"
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances have been launched."
}

output "google_container_cluster_addons_config" {
  value       = "${google_container_cluster.cluster.addons_config}"
  description = "The configurations for addons supported by GKE."
}

output "google_container_cluster_instance_group_urls" {
  value       = "${google_container_cluster.cluster.instance_group_urls}"
  description = "List of instance group URLs which have been assigned to the cluster."
}

output "google_container_cluster_tpu_ipv4_cidr_block" {
  value       = "${google_container_cluster.cluster.subnetwork}"
  description = "The IP address range of the Cloud TPUs in this cluster, in CIDR notation (e.g. 1.2.3.4/29)."
}

# In Beta


# output "google_container_cluster_enable_binary_authorization" {
# value       = "${google_container_cluster.cluster.enable_binary_authorization}"
# description = "Enable Binary Authorization setting. If enabled, all container images will be validated by Google Binary Authorization."
# }


# output "google_container_cluster_enable_tpu" {
# value       = "${google_container_cluster.cluster.enable_tpu}"
# description = "Enable Cloud TPU resources in this cluster setting."
# }


# output "google_container_cluster_pod_security_policy_config" {
# value       = "${google_container_cluster.cluster.pod_security_policy_config}"
# description = "Configuration for the PodSecurityPolicy feature."
# }


# output "google_container_cluster_remove_default_node_pool" {
# value       = "${google_container_cluster.cluster.remove_default_node_pool}"
# description = "If true, it means the default node pool was deleted upon cluster creation."
# }


# output "google_container_cluster_istio_config" {
# value       = "${google_container_cluster.cluster.istio_config}"
# description = "The configurations for istio."
# }

