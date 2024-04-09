resource "yandex_compute_instance" "control_node1" {
  name = "control-node-1"
  zone = var.zone

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      name     = "k8s-cluster-disk"
      image_id = data.yandex_compute_image.debian_latest.id
      size     = 40
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
        pubkey   = "${file("/home/sterh/otus/yc_key_pub")}"
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
  name  = "worker-node-${count.index}"
  zone  = var.zone

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian_latest.id
      size     = 40
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
        pubkey   = "${file("/home/sterh/otus/yc_key_pub")}"
      }

    )
    serial-port-enable = 1
  }

  #   scheduling_policy {
  #     preemptible = true
  #   }

}

#Works, bad structure
# module "inventory_production" {
#   source  = "Peymanpn/ansible-inventory/local"
#   version = "0.6.3"

#   servers = {
#     controller = [yandex_compute_instance.control_node1.network_interface.0.nat_ip_address]   # for a single server
#     workers = yandex_compute_instance.worker_node.*.network_interface.0.nat_ip_address   # for a list of managers
#   }

#   global_vars = {
#     operating_system        = "debian"
#     ansible_user            = "clouduser"
#     ansible_ssh_private_key_file = "~/otus/yc_key_priv"

#   }

#   servers_labels = { # generates json encoded labels
#   }

#   output  = "example_hosts.ini"
# }

module "ansible_inv" {
  source  = "mschuchard/ansible-inv/local"
  version = "~> 1.2.0"
  formats = ["yaml"]
  #instances = yandex_compute_instance.control_node1.network_interface.0.nat_ip_address

  instances = {
    "controllers" = {
      children = []
      hosts = [
        {
          name = yandex_compute_instance.control_node1.name
          ip   = yandex_compute_instance.control_node1.network_interface.0.nat_ip_address
          vars = { "ansible_user" = "clouduser", "ansible_ssh_private_key_file" = "~/otus/yc_key_priv" }
        }
      ]
    },
    "workers" = {
      children = []
      hosts = [
        for worker in(yandex_compute_instance.worker_node)[*] :
        {
          "name" : worker.name
          "ip" : worker.network_interface.0.nat_ip_address
          "vars" : { "ansible_user" = "clouduser", "ansible_ssh_private_key_file" = "~/otus/yc_key_priv" }
        }
      ]
    }
  }


}
