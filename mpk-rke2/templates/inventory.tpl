---
all:
  vars:
    install_rke2_version: ${install_rke2_version}
    # # In air-gapped envs, it might be convenient to download the tar files from custom URLs
    # rke2_tarball_url: https://github.com/rancher/rke2/releases/download/v1.26.15%2Brke2r1/rke2.linux-amd64.tar.gz
    # rke2_image_tar_urls:
    # - https://github.com/rancher/rke2/releases/download/v1.26.15%2Brke2r1/rke2-images-canal.linux-amd64.tar.zst
    # - https://github.com/rancher/rke2/releases/download/v1.26.15%2Brke2r1/rke2-images-core.linux-amd64.tar.zst

rke2_cluster:
  children:
    rke2_servers:
      vars:
        # # Set generic rke2_config at the group level.
        # # Every host in this group will inherit these rke2 configurations
        # # See https://docs.rke2.io/reference/server_config for more options
        # # These options can also be set in the group_vars folder
        rke2_config:
          node-label: ${rke2_servers_node_label}
          cluster-cidr: ${cluster-cidr}
          service-cidr: ${service-cidr}
          cluster-domain: ${cluster-domain}
          cni: ${cni}
          %{~ if kube-controller-manager-arg != null ~}
          kube-controller-manager-arg:
          %{~ for arg in kube-controller-manager-arg ~}
          - ${arg}
          %{~endfor~}
          %{~endif~}
          %{~ if kube-scheduler-arg != null ~}
          kube-scheduler-arg:
          %{~ for arg in kube-scheduler-arg ~}
          - ${arg}
          %{~endfor~}
          %{~endif~}
          %{~ if kube-apiserver-arg != null ~}
          kube-apiserver-arg:
          %{~ for arg in kube-apiserver-arg ~}
          - ${arg}
          %{~endfor~}
          %{~endif~}
          %{~ if kubelet-arg != null ~}
          kubelet-arg:
          %{~ for arg in kubelet-arg ~}
          - ${arg}
          %{~endfor~}
          %{~endif~}
          %{~ if etcd-arg != null ~}
          etcd-arg:
          %{~ for arg in etcd-arg ~}
          - ${arg}
          %{~endfor~}
          %{~endif~}
          %{~ if kube-proxy-arg	 != null ~}
          kube-proxy-arg	:
          %{~ for arg in kube-proxy-arg	 ~}
          - ${arg}
          %{~endfor~}
          %{~endif~}

          
      hosts:
        # # Optional hostvars that can be pased in to individual nodes include
        # # node_ip, node_name, bind_address, advertise_address, node_taints=[],
        # # node_labels=[], and node_external_ip
        ${rke2_master1.fqdn}:
          node_name: ${rke2_master1.fqdn}
          node_ip: ${rke2_master1.ip}
          node_labels: ${rke2_master1.labels}     
          %{~ if rke2_master_node_taints != null ~}
          node_taints: ${rke2_master_node_taints}
          %{~ endif ~}
        ${rke2_master2.fqdn}:
          node_name: ${rke2_master2.fqdn}
          node_ip: ${rke2_master2.ip}
          node_labels: ${rke2_master2.labels} 
          %{~ if rke2_master_node_taints != null ~}
          node_taints: ${rke2_master_node_taints}
          %{~ endif ~}          
        ${rke2_master3.fqdn}:
          node_name: ${rke2_master3.fqdn}
          node_ip: ${rke2_master3.ip}
          node_labels: ${rke2_master3.labels}
          %{~ if rke2_master_node_taints != null ~}
          node_taints: ${rke2_master_node_taints}
          %{~ endif ~}     
          # node_ip: "10.10.10.10"
          # node_name: "server0.example.com"
          # bind_address: "10.10.10.10"
          # advertise_address: "10.10.10.10"
          # node_external_ip: "52.52.52.52"
          # node_taints:
          # - CriticalAddonsOnly=true:NoSchedule
          # cloud_provider_name: "aws"
    rke2_agents:
      vars:
        rke2_config:
          node-label: ${rke2_agents_node_label}
      hosts:
  
