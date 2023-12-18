
resource "yandex_compute_instance" "privatevm" {
  name        = local.privatevm_name
  platform_id = "standard-v1"
  hostname = local.privatevm_name
  resources {
    cores         = var.vm_resources.core
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = 6
    }


  }
  scheduling_policy {
    preemptible = var.vm_premtible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.privatenet.id
    nat       = var.vmprivate_nat
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.metadata.ssh-keys}"
  }

}


