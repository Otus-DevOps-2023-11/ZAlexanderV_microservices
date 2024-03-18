
resource "yandex_compute_instance" "docker_app" {
  count = var.docker_count
  name  = "docker-app-${count.index}"
  zone  = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  labels = {
    service = "docker"
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
    service  = "docker_meta"
  }

# Создание динамического inventory для Ansible для подключения к APP_GW
data "template_file" "inventory" {
    template = file("./_templates/inventory.tpl")

    vars = {
        user = "ubuntu"
        host = join("", [yandex_compute_instance.vm.name, " ansible_host=", yandex_compute_instance.vm.network_interface.0.nat_ip_address])
    }
}

resource "local_file" "save_inventory" {
   content  = data.template_file.inventory.rendered
   filename = "./inventory"
}

}
