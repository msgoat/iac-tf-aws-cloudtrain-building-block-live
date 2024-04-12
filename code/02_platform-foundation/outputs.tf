output "k8s_cluster_id" {
  description = "Unique identifier of the Kubernetes cluster"
  value       = module.k8s_foundation.k8s_cluster_id
}

output "network_id" {
  description = "Unique identifier name of the network hosting the Kubernetes cluster"
  value       = module.k8s_foundation.network_id
}

output "loadbalancer_id" {
  description = "Unique identifier of the load balancer supposed to route traffic to the Kubernetes cluster"
  value       = module.k8s_foundation.loadbalancer_id
}

