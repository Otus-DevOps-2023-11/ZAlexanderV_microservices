resource "yandex_compute_instance" "control_node1" {
  name = "control-node-1"
  zone = var.zone

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      name = "k8s-cluster-disk"
      image_id = data.yandex_compute_image.debian_latest.id
      size = 40
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = data.yandex_vpc_subnet.default_a.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/sterh/otus/yc_key_pub")}"
    user-data = templatefile("templates/cloud_init.cfg",
      {
        hostname = "master1",
        pubkey     = "${file("/home/sterh/otus/yc_key_pub")}"
      }

    )
    serial-port-enable = 1
  }

#   scheduling_policy {
#     preemptible = true
#   }

}

resource "yandex_compute_instance" "worker_node" {
  count = 2
  name = "worker-node-${count.index}"
  zone = var.zone

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian_latest.id
      size = 40
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = data.yandex_vpc_subnet.default_a.id
    nat       = true
  }

  metadata = {
    user-data = templatefile("templates/cloud_init.cfg",
      {
        hostname = "worker-node-${count.index}",
        pubkey     = "${file("/home/sterh/otus/yc_key_pub")}"
      }

    )
    serial-port-enable = 1
  }

#   scheduling_policy {
#     preemptible = true
#   }

}
