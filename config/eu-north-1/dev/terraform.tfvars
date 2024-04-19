region_name="eu-north-1"
solution_name="iactrain"
solution_stage="dev"
solution_fqn="iactrain-dev"
common_tags={
  Organization = "msg systems ag"
  BusinessUnit = "Branche Automotive"
  Department = "PG Cloud"
  ManagedBy = "Terraform"
}
backend_name = "tfbblox2024"
tfstate_region = "eu-north-1"
tfstate_bucket = "s3-eu-north-1-iactrain-dev-tfbblox2024"
tfstate_dynamodb_table = "dyn-eu-north-1-iactrain-dev-tfbblox2024"
public_dns_zone_name = "tfbblox2024-dev.cloudtrain.aws.msgoat.eu"
host_names = ["tfbblox2024-dev.cloudtrain.aws.msgoat.eu"]
parent_dns_zone_id = "Z0656421399R1M1TYM2HZ"
network_cidr="10.17.0.0/16"
zones_to_span=["eu-north-1a", "eu-north-1b"]
kubernetes_version="1.29"
kubernetes_cluster_name="k8stst2024"
kubernetes_cluster_architecture="ARM_64"
kubernetes_api_access_cidrs=[ "0.0.0.0/0" ]
kubernetes_workload_access_cidrs=[ "0.0.0.0/0" ]
node_group_templates=[
  {
    name               = "appsblue"       # logical name of this nodegroup
    min_size           = 1       # minimum size of this node group
    max_size           = 2       # maximum size of this node group
    desired_size       = 1       # desired size of this node group; will default to min_size if set to 0
    disk_size          = 64       # size of attached root volume in GB
    instance_types     = [ "t4g.xlarge" ] # virtual machine instance types which should be used for the worker node groups ordered descending by preference
    cpu_architecture   = "ARM_64"
  }
]
admin_principal_ids = [ "cloudtrain-power-user" ]
letsencrypt_account_name = "msg.O.GBA.CloudTrain@msg.group"
# Controls if OpenTelemetry support should be enabled
opentelemetry_enabled = true
# Host name of the OpenTelemetry collector endpoint; required if `opentelemetry_enabled` is true
opentelemetry_collector_host = "tracing-jaeger-collector.tracing"
# Port number of the OpenTelemetry collector endpoint; required if `opentelemetry_enabled` is true
opentelemetry_collector_port = 4317
kubernetes_namespace_templates = [{ name = "cloudtrain" }]
postgresql_templates = [
  {
    instance_name = "tfbblox2024"
    database_name = "iactrain"
    instance_type = "db.t4g.micro"
    min_storage_size = 20
    max_storage_size = 40
    storage_type = "gp3"
    version = "16.1"
    final_snapshot_enabled = false
  }
]
