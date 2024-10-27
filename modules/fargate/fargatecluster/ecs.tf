resource "aws_ecs_cluster" "ecs_clstr_prj" {
  name = "${var.application_code}-clstr-${var.env}"
}

