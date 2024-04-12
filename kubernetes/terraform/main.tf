resource "yandex_kubernetes_cluster" "zonal_cluster_reddit" {
  name        = "reddit-app"
  description = "Reddit app cluster"
  network_id  = data.yandex_vpc_network.default.id # "enpm3j82hr16pfrck0v8"
  master {
    version = "1.26"
    zonal {
      zone      = var.zone
      subnet_id = var.subnet_id
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "02:00"
        duration   = "2h"
      }
    }

    master_logging {
      enabled                    = true
      kube_apiserver_enabled     = true
      cluster_autoscaler_enabled = true
      events_enabled             = true
      audit_enabled              = true
    }
  }

  service_account_id      = data.yandex_iam_service_account.k8s_master.id
  node_service_account_id = data.yandex_iam_service_account.k8s_worker.id

  labels = {
    application = "reddit"
    environment = "dev"
  }

  release_channel         = "RAPID"
  network_policy_provider = "CALICO"
}

resource "yandex_kubernetes_node_group" "reddit_node_group" {
  cluster_id  = yandex_kubernetes_cluster.zonal_cluster_reddit.id
  name        = "work-node"
  description = "description"
  version     = "1.26"

  labels = {
    "application" = "reddit"
    "environment" = "dev"
  }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat        = true
      subnet_ids = [var.subnet_id]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "03:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "23:00"
      duration   = "4h30m"
    }
  }
}
