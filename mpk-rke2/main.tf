resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl", {
    install_rke2_version        = var.install_rke2_version
    cluster-cidr                = var.cluster-cidr
    service-cidr                = var.service-cidr
    cluster-domain              = var.cluster-domain
    cni                         = var.cni
    rke2_servers_node_label     = var.rke2_servers_node_label
    rke2_agents_node_label      = var.rke2_agents_node_label
    rke2_master1                = var.rke2_master1
    rke2_master2                = var.rke2_master2
    rke2_master3                = var.rke2_master3
    rke2_master_node_taints     = var.rke2_master_node_taints
    kube-controller-manager-arg = var.kube-controller-manager-arg
    kube-scheduler-arg          = var.kube-scheduler-arg
    kube-apiserver-arg          = var.kube-apiserver-arg
    kubelet-arg                 = var.kubelet-arg
    etcd-arg                    = var.etcd-arg
    kube-proxy-arg              = var.kube-proxy-arg
  })
  filename = "${path.module}/../rke2-ansible/inventory/hosts.yml"
}

resource "null_resource" "deploy_rke2" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ANSIBLE_ROLES_PATH=${path.module}/../rke2-ansible/roles/ ansible-playbook -i ${path.module}/../rke2-ansible/inventory/hosts.yml ${path.module}/../rke2-ansible/playbooks/site.yml"
  }
  triggers = {
    name = local_file.ansible_inventory.id
  }
}