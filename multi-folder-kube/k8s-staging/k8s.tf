resource "yandex_kubernetes_cluster" "staging_cluster" {
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_admin_network,
    yandex_resourcemanager_folder_iam_member.k8s_admin_user,
    yandex_resourcemanager_folder_iam_member.k8s_node_group
  ]
  name        = "staging"
  description = "staging cluster"
  folder_id = local.staging-folder-id
  cluster_ipv4_range = "10.113.0.0/16"
  service_ipv4_range = "10.97.0.0/16"

  network_id = local.network-id

  master {
    version     = "1.14"
    zonal {
      zone      = local.zone
      subnet_id = local.staging-subnet-id
    }

    public_ip = true
  }

  service_account_id      = yandex_iam_service_account.k8s_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_node_sa.id


  release_channel = "STABLE"
}

resource "yandex_kubernetes_node_group" "staging_ng" {
  cluster_id  = yandex_kubernetes_cluster.staging_cluster.id
  name        = "staging-ng"
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
      subnet_id = local.staging-subnet-id
    }
  }
}
