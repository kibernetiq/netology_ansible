resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "centos" {
  family = var.vm_web_yandex_compute_image
}

resource "yandex_compute_instance" "clickhouse"{
  name = "${local.project}-${local.env_web}"
  platform_id = var.vm_web_yandex_compute_instance_platform_id
  resources {
    cores         = 2
    memory        = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata_map.metadata["serial-port-enable"]
    ssh-keys           = "${local.ssh_key}"
  }
}