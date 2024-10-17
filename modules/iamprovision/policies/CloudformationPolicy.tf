resource "aws_iam_policy" "cloudformationPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_cloudformation_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_cloudformation_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllow"
        Action = [
          "cloudformation:EstimateTemplateCost",
          "cloudformation:ValidateTemplate",
          "cloudformation:Describe*",
          "cloudformation:List*",
          "cloudformation:Get*",
          "cloudformation:CreateStackSet"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "BoundedByNamespace"
        Action = [
          "cloudformation:*",
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:cloudformation:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stack/${var.NameSpace}*/*",
          "arn:aws:cloudformation:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stackset/${var.NameSpace}*/*"

        ]
      }
    ]
  })
}