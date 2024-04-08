terraform {
  required_version = "~> 1.7.4"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }

    ansible = {
      source  = "ansible/ansible"
      version = "1.2.0"
    }
  }
}
