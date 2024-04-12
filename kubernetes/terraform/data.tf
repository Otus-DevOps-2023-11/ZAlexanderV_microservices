data "yandex_compute_image" "debian_latest" {
  family = "debian-12"
}

data "yandex_vpc_subnet" "default_a" {
  name = "default-ru-central1-a" # одна из дефолтных подсетей
}

data "yandex_iam_service_account" "k8s_master" {
  name = var.k8s_svc_account
}

data "yandex_iam_service_account" "k8s_worker" {
  name = var.k8s_worker_svc_account
}

data "yandex_vpc_network" "default" {
  name = "default"
}
