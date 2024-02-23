output "docker_ip_address" {
  value = (formatlist(
    "id = %s: ext ip = %s, int ip = %s",
    yandex_compute_instance.docker_app[*].id,
    yandex_compute_instance.docker_app[*].network_interface.0.nat_ip_address,
    yandex_compute_instance.docker_app[*].network_interface.0.ip_address
  ))
}
