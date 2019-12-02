resource "yandex_iam_service_account" "k8s_sa" {
  folder_id = local.production-folder-id
  name        = "k8s-sa-production"
  description = "service account for cluster"
}

resource "yandex_iam_service_account" "k8s_node_sa" {
  folder_id = local.production-folder-id
  name        = "k8s-node-sa-production"
  description = "service account for nodes"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_admin_network" {
  folder_id = local.network-folder-id

  role = "editor"
  member = "serviceAccount:${yandex_iam_service_account.k8s_sa.id}"

}

resource "yandex_resourcemanager_folder_iam_member" "k8s_admin_user" {
  folder_id = local.production-folder-id

  role = "editor"

  member  = "serviceAccount:${yandex_iam_service_account.k8s_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_node_group" {
  folder_id = local.production-folder-id

  role = "container-registry.images.puller"

  member = "serviceAccount:${yandex_iam_service_account.k8s_node_sa.id}"
}
