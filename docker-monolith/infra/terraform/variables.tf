variable "cloud_id" {
  description = "YC Cloud ID"
  type        = string
  default     = "b1gdpe4f6jqggbrpqgsr"
}
variable "folder_id" {
  description = "Folder"
  type        = string
  default     = "b1gs4m14eth4n4rjck3k"
}
variable "zone" {
  description = "Zone"
  type        = string
  default     = "ru-central1-a"
}
variable "subnet_id" {
  description = "Subnet"
  type        = string
  default     = "e9bgt4su1ihc5selb1pp"
}
variable "private_key_path" {
  description = "Path to the private key"
  type        = string
  default     = "~/otus/yc_key_priv"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
  type        = string
  default     = "~/otus/yc_key_pub"
}
variable "service_account_key_file" {
  description = "key.json"
  default     = "~/otus/yandex_svc_key.json"
}
variable "docker_count" {
  description = "app count"
  default     = "1"
}
variable "docker_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8n3ngpoa90gprd984f"
}
data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2204-lts"
}
