variable "region_name" {
  description = "The name of the region to deploy into."
  type        = string
}

variable "solution_name" {
  description = "The name of the cloud solution that owns all cloud resources."
  type        = string
}

variable "solution_stage" {
  description = "The name of the current solution stage."
  type        = string
}

variable "solution_fqn" {
  description = "The fully qualified name of the cloud solution."
  type        = string
}

variable "common_tags" {
  description = "Common tags to be attached to all cloud resources"
  type        = map(string)
}

variable "admin_principal_ids" {
  description = "List of principal IDs (groups or roles) which grant administrative access components of this solution"
  type        = list(string)
}

variable "tfstate_region" {
  description = "Name of the region hosting the remote Terraform state."
  type        = string
}

variable "tfstate_bucket" {
  description = "Name of the S3 bucket containing the remote Terraform state."
  type        = string
}

variable "tfstate_dynamodb_table" {
  description = "Name of the DynamoDB table managing the remote Terraform state."
  type        = string
}

variable "letsencrypt_account_name" {
  description = "Lets Encrypt Account name to be used to request TLS certificates"
  type        = string
}

variable "kubernetes_cluster_architecture" {
  description = "Processor architecture of the worker nodes of the target Kubernetes cluster; allowed values are: `X86_64` (default), `ARM_64`"
  type        = string
  validation {
    condition     = var.kubernetes_cluster_architecture == "X86_64" || var.kubernetes_cluster_architecture == "ARM_64"
    error_message = "The kubernetes_cluster_architecture must be either `X86_64` (Intel-based 64 bit) or `ARM_64` (ARM-based 64 bit)"
  }
}

variable "host_names" {
  description = "Host names of all hosts whose traffic should be routed to this solution"
  type        = list(string)
  default     = []
}

variable "opentelemetry_enabled" {
  description = "Controls if OpenTelemetry support should be enabled"
  type        = bool
}

variable "opentelemetry_collector_host" {
  description = "Host name of the OpenTelemetry collector endpoint; required if `opentelemetry_enabled` is true"
  type        = string
}

variable "opentelemetry_collector_port" {
  description = "Port number of the OpenTelemetry collector endpoint; required if `opentelemetry_enabled` is true"
  type        = number
}

variable "kubernetes_namespace_templates" {
  description = "Templates for the Kubernetes namespaces to create"
  type = list(object({
    name                    = string
    labels                  = optional(map(string), {})
    network_policy_enforced = optional(bool, false)
  }))
}
