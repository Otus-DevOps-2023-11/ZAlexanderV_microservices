locals {
  list-workers = [
    for worker in(yandex_compute_instance.worker_node)[*] :
    {
      "name" : worker.name
      "ip" : worker.network_interface.0.nat_ip_address
      "vars" : { "ansible_user" = "clouduser", "ansible_ssh_private_key_file" = "~/otus/yc_key_priv" }
    }
  ]
}
