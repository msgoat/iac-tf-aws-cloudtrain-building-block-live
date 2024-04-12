# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    # Please provide all other information via the -backend-config command line argument
    key = "tfbblox2024/dev/platform-foundation.tfstate"
  }
}

provider "aws" {
  region = var.region_name
}

data "terraform_remote_state" "stage_shared" {
  backend = "s3"
  config = {
    region         = var.tfstate_region
    bucket         = var.tfstate_bucket
    dynamodb_table = var.tfstate_dynamodb_table
    key            = "tfbblox2024/dev/stage-shared.tfstate"
  }
}

module "k8s_foundation" {
  source                           = "../../../iac-tf-aws-cloudtrain-building-block-modules//modules/container/kubernetes/foundation"
  region_name                      = var.region_name
  solution_name                    = var.solution_name
  solution_stage                   = var.solution_stage
  solution_fqn                     = var.solution_fqn
  common_tags                      = var.common_tags
  network_cidr                     = var.network_cidr
  zones_to_span                    = var.zones_to_span
  kubernetes_api_access_cidrs      = var.kubernetes_api_access_cidrs
  kubernetes_workload_access_cidrs = var.kubernetes_workload_access_cidrs
  kubernetes_cluster_name          = var.kubernetes_cluster_name
  kubernetes_version               = var.kubernetes_version
  node_group_templates             = var.node_group_templates
  public_dns_zone_id               = data.terraform_remote_state.stage_shared.outputs.public_dns_zone_id
}
