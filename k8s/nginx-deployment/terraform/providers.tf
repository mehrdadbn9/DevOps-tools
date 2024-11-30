provider "kubernetes" {
  config_path    = var.kube_config
  config_context = var.kube_context
}

provider "helm" {
  kubernetes {
    config_path    = var.kube_config
    config_context = var.kube_context
  }
}

# Add kube_context variable
variable "kube_context" {
  type        = string
  default     = ""
  description = "Kubernetes context to use"
}
