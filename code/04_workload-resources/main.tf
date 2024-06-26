# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
  backend "s3" {
    # Please provide all other information via the -backend-config command line argument
    key = "tfbblox2024/dev/workload-resources.tfstate"
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

data "terraform_remote_state" "platform_foundation" {
  backend = "s3"
  config = {
    region         = var.tfstate_region
    bucket         = var.tfstate_bucket
    dynamodb_table = var.tfstate_dynamodb_table
    key            = "tfbblox2024/dev/platform-foundation.tfstate"
  }
}

# Kubernetes-related Terraform Providers -------------------------------------

data "aws_eks_cluster" "given" {
  name = data.terraform_remote_state.platform_foundation.outputs.k8s_cluster_id
}

data "aws_eks_cluster_auth" "given" {
  name = data.aws_eks_cluster.given.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.given.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.given.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.given.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.given.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.given.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.given.token
  }
}

module postgresql {
  source                          = "../../../iac-tf-aws-cloudtrain-building-block-modules//modules/database/postgresql"
  region_name                     = var.region_name
  solution_name                   = var.solution_name
  solution_stage                  = var.solution_stage
  solution_fqn                    = var.solution_fqn
  common_tags                     = var.common_tags
  postgresql_templates            = var.postgresql_templates
  vpc_id = data.terraform_remote_state.platform_foundation.outputs.network_id
  k8s_cluster_id = data.terraform_remote_state.platform_foundation.outputs.k8s_cluster_id
}