output "zone" {
  value = var.zone
}
output "network-folder-id" {
  value = var.network_folder_id
}

output "network-id" {
  value = yandex_vpc_network.multi-folder-network.id
}


output "staging-subnet-id" {
  value = yandex_vpc_subnet.staging-subnet.id
}

output "staging-folder-id" {
  value = var.staging_folder_id
}

output "production-subnet-id" {
  value = yandex_vpc_subnet.production-subnet.id
}
output "production-folder-id" {
  value = var.production_folder_id
}
