output "controler_ip" {
  value = {
    name      = yandex_compute_instance.control_node1.name
    public_ip = yandex_compute_instance.control_node1.network_interface.0.nat_ip_address
  }
}

output "workers_ips" {
  value = local.list-workers
}
