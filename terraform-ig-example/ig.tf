provider "yandex" {
  token     = "${var.token}"
  cloud_id  = "${var.cloud_id}"
  folder_id = "${var.folder_id}"

}

data "yandex_compute_image" "base_image" {
  family = "${var.yc_image_family}"
}


data "template_file" "cloud_init" {
  template = "${file("cloud-init.tpl.yaml")}"
  vars =  {

        ssh_key = "${file(var.public_key_path)}"

    }
}

resource "yandex_compute_instance_group" "ig" {
  name               = "instance-group-test1"
  service_account_id = "${yandex_iam_service_account.ig_sa.id}"
  folder_id = "${var.folder_id}"

  instance_template {
    platform_id = "standard-v2"
    resources {
      cores  = 2
      memory = 4

    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "${data.yandex_compute_image.base_image.id}"
        size     = 32
      }
    }
    network_interface {
      subnet_ids = "${yandex_vpc_subnet.subnet.*.id}"
      nat=true
    }

    metadata = {
      user-data = "${data.template_file.cloud_init.rendered}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = "${var.zones}"
  }

  load_balancer {
    target_group_name = "ig-tg"
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion = 0
  }
}
