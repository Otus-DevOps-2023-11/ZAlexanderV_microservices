variable "service_account_key_file" {
  description = "YC service acccount file json format"
  type        = string
  default     = null
}

variable "cloud_id" {
  description = "YC Cloud ID"
  type        = string
  default     = null
}

variable "folder_id" {
  description = "Folder to create resource"
  type        = string
  default     = null
}

variable "zone" {
  description = "YC Zone ID"
  default     = "ru-central1-a"
  validation {
    condition     = var.zone == null ? true : contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.zone)
    error_message = "Only a valid YC region names are expected here such as ru-central1-a."
  }
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
  type        = string
  default     = null
}

variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "YC Subnet ID"
  type        = string
  default     = null
}

variable "k8s_svc_account" {
  description = "YC K8s service account"
  type        = string
  default     = null
}

variable "k8s_worker_svc_account" {
  description = "YC K8s service account"
  type        = string
  default     = null
}
