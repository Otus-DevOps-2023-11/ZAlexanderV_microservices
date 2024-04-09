terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}
