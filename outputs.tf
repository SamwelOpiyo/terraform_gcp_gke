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

output "cluster_name" {
  value = "${var.cluster_name}"
}

output "cluster_zone" {
  value = "${var.cluster_zone}"
}

output "cluster_endpoint" {
  value       = "${google_container_cluster.cluster.endpoint}"
  description = "Endpoint for accessing the master node"
}

output "client_certificate" {
  value = "${google_container_cluster.cluster.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.cluster.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.cluster.master_auth.0.cluster_ca_certificate}"
}

output "google_service_account_cluster_service_account_email" {
  value = "${google_service_account.cluster-service-account.email}"
}

output "google_service_account_cluster_service_account_unique_id" {
  value = "${google_service_account.cluster-service-account.unique_id}"
}

output "google_service_account_cluster_service_account_name" {
  value = "${google_service_account.cluster-service-account.name}"
}

output "google_service_account_cluster_service_account_display_name" {
  value = "${google_service_account.cluster-service-account.display_name}"
}

output "google_service_account_cluster_service_account_key_name" {
  value = "${google_service_account_key.cluster-service-account-key.name}"
}

output "google_service_account_cluster_service_account_key_public_key" {
  value = "${google_service_account_key.cluster-service-account-key.public_key}"
}

output "google_service_account_cluster_service_account_key_private_key" {
  value = "${google_service_account_key.cluster-service-account-key.private_key}"
}

output "google_service_account_cluster_service_account_key_valid_after" {
  value = "${google_service_account_key.cluster-service-account-key.valid_after}"
}

output "google_service_account_cluster_service_account_key_valid_before" {
  value = "${google_service_account_key.cluster-service-account-key.valid_before}"
}
