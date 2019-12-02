provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

terraform {
  backend "s3" {
    bucket                      = "<STATE_BUCKET>"
    key                         = "multifolder-vpc/network.tfstate"
    region                      = "us-east-1"
    endpoint                    = "storage.yandexcloud.net"
    skip_region_validation      = "true"
    skip_credentials_validation = "true"
  }
}
