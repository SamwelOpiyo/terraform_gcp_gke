# Directory Description

This repository contains terraform module used to create a Kubernetes cluster in Google Cloud Platform after provisioning Google Cloud Project.

## Environment Variables/Terraform Variables

To assign variables check https://www.terraform.io/intro/getting-started/variables.html#assigning-variables.

The following variables must be set:

### Compulsory

* project_name: Project Name or name to create the cluster in.
* project_id: Project ID or name to create the cluster in.
* client_email: Email of user/service account used to authenticate gcloud. This is used when retrieving kubeconfig file.
* cluster_name: Name of kubernetes cluster
* gke_master_password: password of master node of kubernetes cluster

### Non-Compulsory

| Variable | Default Value | Description|
|---       |---            |---         |
| region | europe-west1 | GCP Region. |
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
