variable "public_key_path" {
  description = "Path to public key file"
}

variable "token" {
  description = "Yandex Cloud security OAuth token"
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID where resources will be created"
}

variable "cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
}

variable "minion_key" {
  description = "test"
  default = "lkdashkhjdsa"
}


variable "zone" {
  description = "Yandex Cloud default Zone for provisoned resources"
  default = "ru-central1-a"
}


variable "router_subnets" {
  description = "Yandex Cloud default Zone for provisoned resources"
  default = []
}


variable "zones" {
  description = "Yandex Cloud default Zone for provisoned resources"
  default = ["ru-central1-a","ru-central1-b","ru-central1-c"]
}

variable "yc_image_family" {
  description = "family"
}

# example specific
variable "image_id" {
  default = "fd87va5cc00gaq2f5qfb" # it's ubuntu-1804-lts
}

variable "cluster_size" {
  default = 6
}

variable "instance_cores" {
  description = "Cores per one instance"
  default     = "2"
}

variable "instance_memory" {
  description = "Memory in GB per one instance"
  default     = "2"
}
