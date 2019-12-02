variable "public_key_path" {
  description = "Path to public key file"
}

variable "token" {
  description = "Yandex Cloud security OAuth token"
}



variable "cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
}

variable "zone" {
  description = "Yandex Cloud default Zone for provisoned resources"
  default     = "ru-central1-a"
}

variable "zones" {
  description = "Yandex Cloud default Zone for provisoned resources"
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}
