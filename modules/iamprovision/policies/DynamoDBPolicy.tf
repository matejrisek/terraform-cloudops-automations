resource "aws_iam_policy" "dynamodbPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_dynamodb_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_dynamodb_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllow"
        Action = [
          "dynamodb:List*",
          "dynamodb:Describe*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "BoundedByNamespace"
        Action =  "dynamodb:*"
        Effect   = "Allow"
        Resource = "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.NameSpace}*"
      }
    ]
  })
}