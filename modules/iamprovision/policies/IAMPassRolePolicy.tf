resource "aws_iam_policy" "iamPassRolePolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_iam_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_iam_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "BoundedByNamespace"
        Action = [
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.NameSpace}_${var.AccountEnv}_*"
      },
      {
        Sid = "ReadAccess"
        Action = [
         "iam:Get*",
         "iam:List*"
        ]
        Effect   = "Allow"
        Resource ="*"
      },
      {
        Sid = "KeysRotationAccess"
        Action = [
         "iam:GetAccessKeyLastUsed",
         "iam:UpdateAccessKey",
         "iam:CreateAccessKey",
         "iam:TagUser"
        ]
        Effect   = "Allow"
        Resource ="arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/USE1-${data.aws_caller_identity.current.account_id}-${var.NameSpace}*"
      }
    ]
  })
}