locals {
  timestamp    = formatdate("YYMMDD-hhmm", timestamp())
  ansible_path = "${path.cwd}/../ansible"
}

variable "yc_catalog_id" {
  type = string
}

variable "svc_account_key_file" {
  type = string
}

variable "src_image_family" {
  type = string
}

variable "yc_subnet_id" {
  type = string
}

variable "inst_disk_size" {
  type    = string
  default = null
}

variable "yc_zone" {
  type    = string
  default = null
}

variable "inst_cpu_num" {
  type    = string
  default = null
}


source "yandex" "docker_host" {
  folder_id                = "${var.yc_catalog_id}"
  zone                     = "${var.yc_zone}"
  image_family             = "docker-base"
  image_name               = "docker-${local.timestamp}"
  platform_id              = "standard-v1"
  service_account_key_file = "${var.svc_account_key_file}"
  source_image_family      = "${var.src_image_family}"
  instance_cores           = "${var.inst_cpu_num}"
  disk_size_gb             = "${var.inst_disk_size}"
  ssh_username             = "ubuntu"
  subnet_id                = "${var.yc_subnet_id}"
  use_ipv4_nat             = true
  labels = {
    os         = "ubuntu"
    technology = "docker"
  }

}

build {
  sources = ["source.yandex.docker_host"]

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "scripts/install_docker.sh"
  }

}
