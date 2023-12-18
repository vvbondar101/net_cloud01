output "external_ip_publicvm" {
  value = yandex_compute_instance.publicvm.network_interface.0.nat_ip_address
}
output "external_ip_privatevm" {
  value = yandex_compute_instance.privatevm.network_interface.0.nat_ip_address
}


