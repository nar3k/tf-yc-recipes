resource "yandex_vpc_network" "multi-folder-network" {
  folder_id = var.network_folder_id
  name      = "multi-folder-k8s-network"
}


resource "yandex_vpc_subnet" "staging-subnet" {
  name           = "${yandex_vpc_network.multi-folder-network.name}-k8s-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.multi-folder-network.id
  v4_cidr_blocks = [var.staging_cidr]
  folder_id      = var.staging_folder_id
}


resource "yandex_vpc_subnet" "production-subnet" {
  name           = "${yandex_vpc_network.multi-folder-network.name}-k8s-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.multi-folder-network.id
  v4_cidr_blocks = [var.production_cidr]
  folder_id      = var.production_folder_id
}
