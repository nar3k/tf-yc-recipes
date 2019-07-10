resource "yandex_vpc_network" "network" {
  name = "ig-demo-network"
}


resource "yandex_vpc_subnet" "subnet" {
  count          = "${var.cluster_size > length(var.zones) ? length(var.zones)  : var.cluster_size}"
  name           = "ig-demo-subnet-${count.index}"
  zone           = "${element(var.zones,count.index)}"
  network_id     = "${yandex_vpc_network.network.id}"
  v4_cidr_blocks = ["192.168.${count.index}.0/24"]
}
