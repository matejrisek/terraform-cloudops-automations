resource "aws_iam_policy" "SecretsManagerPolicy" {
  name        = "rds_admin_secretsmanager_access"
  path        = "/"
  description = "rds_admin_secretsmanager_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllowSecretManager"
        Action = [
          "secretsmanager:*"
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:*_${var.AccountEnv}_rds_master_credentials",
          "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:*_${var.AccountEnv}_rds_application_credentials"
        ]
      },
      {
        "Sid": "AllowAllRead",
        "Effect": "Allow",
        "Action": [
          "secretsmanager:GetRandomPassword",
          "secretsmanager:ListSecrets",
          "secretsmanager:BatchGetSecretValue"
        ],
        "Resource": "*"
      }





    ]
  })
}