resource "aws_iam_policy" "sqsAndSnsPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_sns_sqs_access"
  description = "${var.NameSpace}_${var.AccountEnv}_sns_sqs_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllowSNS"
        Action = [
        "sns:ListTopics",
        "sns:ListSubscriptions"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "BoundedByNamespaceSNS"
        Action = [
          "sns:*"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.NameSpace}*"
      },
      {
        Sid = "UniversalAllowSQS"
        Action = [
          "sqs:ListQueues",
          "sqs:GetQueueAttributes"
        ]
        Effect   = "Allow"
        Resource = "*"

      },
      {
        Sid = "BoundedByNamespaceSQS"
        Action = "sqs:*"
        Effect   = "Allow"
        Resource = "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.NameSpace}*"

      },
      {
        Sid = "OtherPermissionsIAM"
        Action = [
          "cloudformation:DescribeStackResource",
          "iam:ListRoles",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:ListAttachedRolePolicies",
          "iam:ListRolePolicies",
          "ec2:Describe*",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses",
          "kms:ListAliases"
        ]
        Effect   = "Allow"
        Resource = "*"
      }

    ]
  })
}