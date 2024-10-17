resource "aws_security_group" "namespace_custom_sg"{

  name = "SG-${upper(var.NameSpace)}-CUSTOM"
  description = "SG-${upper(var.NameSpace)}-CUSTOM"
  vpc_id      = var.vpcId
  dynamic "ingress" {
    for_each = var.ingress_port_list
    iterator = ingress_port
    content {
      from_port = ingress_port.value
      to_port   = ingress_port.value
      protocol = "tcp"
      cidr_blocks = var.ingress_cidr_list
    }
  }
  tags = {
    Name = "SG-${upper(var.NameSpace)}-CUSTOM"
  }

}