resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.NameSpace}_${var.AccountEnv}_instance_profile"
  role = aws_iam_role.ec2_role.name
}

