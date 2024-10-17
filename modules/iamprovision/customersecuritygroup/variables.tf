variable "NameSpace" {
  type = string
}

variable "vpcId" {
  type = string
}

variable "ingress_port_list" { type = list(string) }

variable "ingress_cidr_list"  {
  type =list(string)
  default = ["192.168.0.0/16","172.16.0.0/12","10.0.0.0/8"]
}