resource "yandex_kubernetes_cluster" "production_cluster" {
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_admin_network,
    yandex_resourcemanager_folder_iam_member.k8s_admin_user,
    yandex_resourcemanager_folder_iam_member.k8s_node_group
  ]
  name        = "production"
  description = "production cluster"
  folder_id = local.production-folder-id

  network_id = local.network-id
  cluster_ipv4_range = "10.112.0.0/16"
  service_ipv4_range = "10.96.0.0/16"

  master {
    version     = "1.14"
    zonal {
      zone      = local.zone
      subnet_id = local.production-subnet-id
    }

    public_ip = true
  }

  service_account_id      = yandex_iam_service_account.k8s_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_node_sa.id


  release_channel = "STABLE"
}

resource "yandex_kubernetes_node_group" "production_ng" {
  cluster_id  = yandex_kubernetes_cluster.production_cluster.id
  name        = "production-ng"
  description = "description"
  version     = "1.14"



  instance_template {
    platform_id = "standard-v2"
    nat         = true

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = local.zone
      subnet_id = local.production-subnet-id
    }
  }
}
