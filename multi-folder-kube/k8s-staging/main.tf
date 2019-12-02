provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
}

terraform {
  backend "s3" {
    bucket                      = "<STATE_BUCKET>"
    key                         = "multifolder-vpc/k8s-staging.tfstate"
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

  staging-subnet-id  = data.terraform_remote_state.network.outputs.staging-subnet-id
  zone  = data.terraform_remote_state.network.outputs.zone
  network-folder-id = data.terraform_remote_state.network.outputs.network-folder-id
  staging-folder-id = data.terraform_remote_state.network.outputs.staging-folder-id
  network-id = data.terraform_remote_state.network.outputs.network-id
}
