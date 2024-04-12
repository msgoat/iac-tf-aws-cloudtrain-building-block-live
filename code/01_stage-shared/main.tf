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
    key = "tfbblox2024/dev/stage-shared.tfstate"
  }
}

provider "aws" {
  region = var.region_name
}


module shared {
  source                = "../../../iac-tf-aws-cloudtrain-building-block-modules//modules/stage/shared"
  region_name           = var.region_name
  solution_name         = var.solution_name
  solution_stage        = var.solution_stage
  solution_fqn          = var.solution_fqn
  common_tags           = var.common_tags
  public_dns_zone_name         = var.public_dns_zone_name
  parent_dns_zone_id    = var.parent_dns_zone_id
  admin_principal_ids       = var.admin_principal_ids
}
