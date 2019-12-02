provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
}

terraform {
  backend "s3" {
    bucket                      = "<STATE_BUCKET>"
    key                         = "multifolder-vpc/k8s-production.tfstate"
    region                      = "us-east-1"
    endpoint                    = "storage.yandexcloud.net"
    skip_region_validation      = "true"
    skip_credentials_validation = "true"
  }
}


data "terraform_remote_state" "network" {
  backend = "s3"
  config   = {
    bucket                      = "<STATE_BUCKET>"
    key                         = "multifolder-vpc/network.tfstate"
    region                      = "us-east-1"
    endpoint                    = "storage.yandexcloud.net"
    skip_region_validation      = "true"
    skip_credentials_validation = "true"
  }
}

locals {

  production-subnet-id  = data.terraform_remote_state.network.outputs.production-subnet-id
  zone  = data.terraform_remote_state.network.outputs.zone
  network-folder-id = data.terraform_remote_state.network.outputs.network-folder-id
  production-folder-id = data.terraform_remote_state.network.outputs.production-folder-id
  network-id = data.terraform_remote_state.network.outputs.network-id
}
