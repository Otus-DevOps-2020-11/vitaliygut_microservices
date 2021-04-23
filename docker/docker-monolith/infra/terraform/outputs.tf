output "external_ip_address_docker" {
  value = yandex_compute_instance.docker.*.network_interface.0.nat_ip_address
}
output "internal_ip_address_docker" {
  value = yandex_compute_instance.docker.*.network_interface.0.ip_address
}

## The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  host-name-docker = yandex_compute_instance.docker.*.name,
  docker-ext-ip = yandex_compute_instance.docker.*.network_interface.0.nat_ip_address
 }
 )
 filename = "../ansible/inventory.ini"
}
