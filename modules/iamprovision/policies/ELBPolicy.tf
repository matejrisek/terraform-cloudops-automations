resource "aws_iam_policy" "elbPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_elb_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_elb_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllow"
        Action = [
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.NameSpace}_${var.AccountEnv}_*"
      },
      {
        Sid = "ReadAccess"
        Action = [
          "elasticloadbalancing:SetWebAcl",
          "elasticloadbalancing:Describe*",
          "ec2:Describe*"
        ]
        Effect   = "Allow"
        Resource ="*"
      },
      {
        Sid = "BoundedByNamespace"
        Action = [
          "elasticloadbalancing:*"
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:elasticloadbalancing:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:listener-rule/net/${var.NameSpace}*/*/*/*",
          "arn:aws:elasticloadbalancing:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:listener/app/${var.NameSpace}*/*/*",
          "arn:aws:elasticloadbalancing:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:listener/net/${var.NameSpace}*/*/*",
          "arn:aws:elasticloadbalancing:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:listener-rule/app/${var.NameSpace}*/*/*/*",
          "arn:aws:elasticloadbalancing:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:loadbalancer/app/${var.NameSpace}*/*",
          "arn:aws:elasticloadbalancing:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:loadbalancer/net/${var.NameSpace}*/*",
          "arn:aws:elasticloadbalancing:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:targetgroup/${var.NameSpace}*/*"
        ]
      }
    ]
  })
}