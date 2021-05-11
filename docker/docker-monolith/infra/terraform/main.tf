provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
resource "yandex_compute_instance" "docker" {
  count = 3
  name = "reddit-docker${format("%02d", count.index + 1)}"
  labels = {
    tags = "reddit-docker"
  }

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.docker_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

    #provisioner "remote-exec" {
  #  script = "${path.module}/files/deploy.sh"
  #}
}