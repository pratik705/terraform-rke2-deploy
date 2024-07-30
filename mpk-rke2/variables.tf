variable "install_rke2_version" {
  type        = string
  description = "The RKE2 version to install"
}

variable "rke2_servers_node_label" {
  type        = string
  description = "rke2_servers node-label"
}

variable "rke2_agents_node_label" {
  type        = string
  default     = ""
  description = "rke2_agents node-label"
}

variable "rke2_master1" {
  type = object({
    fqdn   = string
    ip     = string
    labels = string
  })
  description = "RKE2 master1 node details"
}

variable "rke2_master2" {
  type = object({
    fqdn   = string
    ip     = string
    labels = string
  })
  description = "RKE2 master2 node details"
}

variable "rke2_master3" {
  type = object({
    fqdn   = string
    ip     = string
    labels = string
  })
  description = "RKE2 master3 node details"
}

variable "rke2_master_node_taints" {
  type        = string
  default     = null
  description = "Registering kubelet with set of taints"
}

variable "kube-controller-manager-arg" {
  type        = list(string)
  default     = null
  description = "Customized flag for kube-controller-manager process"
}

variable "kube-scheduler-arg" {
  type        = list(string)
  default     = null
  description = "Customized flag for kube-scheduler process"
}

variable "kube-apiserver-arg" {
  type        = list(string)
  default     = null
  description = "Customized flag for kube-apiserver process"
}

variable "kubelet-arg" {
  type        = list(string)
  default     = null
  description = "Customized flag for kubelet process"
}

variable "etcd-arg" {
  type        = list(string)
  default     = null
  description = "Customized flag for etcd process"
}

variable "cluster-cidr" {
  type        = string
  default     = "10.42.0.0/16"
  description = "IPv4 network CIDRs to use for pod IPs"
}

variable "service-cidr" {
  type        = string
  default     = "10.43.0.0/16"
  description = "IPv4 network CIDRs to use for service IPs	"
}

variable "cluster-domain" {
  type        = string
  default     = "cluster.local"
  description = "Cluster Domain"
}

variable "cni" {
  type        = string
  default     = "canal"
  description = "CNI Plugins to deploy, one of none, calico, canal, cilium; optionally with multus as the first value to enable the multus meta-plugin"
}

variable "kube-proxy-arg" {
  type        = list(string)
  default     = null
  description = "Customized flag for kube-proxy process"
}