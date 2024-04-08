data "yandex_compute_image" "debian_latest" {
  family = "debian-12"
}

data "yandex_vpc_subnet" "default_a" {
  name = "default-ru-central1-a"  # одна из дефолтных подсетей
}
