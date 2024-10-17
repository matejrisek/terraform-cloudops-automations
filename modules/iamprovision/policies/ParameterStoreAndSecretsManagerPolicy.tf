resource "aws_iam_policy" "parameterStroeAndSecretsManagerPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_ssm_secretsmanager_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_ssm_secretsmanager_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllowSecretManager"
        Action = [
          "secretsmanager:GetRandomPassword",
          "secretsmanager:ListSecrets",
          "rds:DescribeDBClusters",
          "rds:DescribeDBInstances",
          "redshift:DescribeClusters"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "BoundedByNamespaceSecretManager"
        Action = [
          "secretsmanager:*",
        ]
        Effect   = "Allow"
        Resource ="arn:aws:secretsmanager::${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${var.NameSpace}*"

      },
      {
        Sid = "UniversalAllowSSM"
        Action = [
          "ssm:DescribeParameters",
          "kms:ListAliases"
        ]
        Effect   = "Allow"
        Resource = "*"

      },
      {
        Sid = "BoudedByNamespaceSSM"
        Action = [
          "ssm:PutParameter",
          "ssm:DeleteParameter",
          "ssm:GetParameterHistory",
          "ssm:ListTagsForResource",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:ListTagsForResource",
          "ssm:DeleteParameters",
          "ssm:RemoveTagsFromResource",
          "ssm:AddTagsToResource"
        ]
        Effect   = "Allow"
        Resource ="arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.NameSpace}*"

      },
      {
        Sid = "SSMPermissionsforECSExecute"
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "OtherPermissionsIAM"
        Action = [
          "cloudformation:DescribeResources",
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