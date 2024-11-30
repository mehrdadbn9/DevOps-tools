variable "kube_config" {
  type        = string
  default     = "~/.kube/config"
  description = "Path to the kubeconfig file"
}

variable "namespace" {
  type        = string
  default     = "default"
  description = "Kubernetes namespace for the deployment"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment name (dev/prod)"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}
