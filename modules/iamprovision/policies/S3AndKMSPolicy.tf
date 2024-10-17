resource "aws_iam_policy" "s3AndKmsPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_s3_kms_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_s3_kms_access"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "ListingBuckets"
        Action = [
          "s3:ListAllMyBuckets",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "ListingObjects"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::us.com.syngenta.${var.NameSpace}*"
      },
      {
        Sid = "BoundedByNamespace"
        Action = [
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::us.com.syngenta.${var.NameSpace}*",
          "arn:aws:s3:::us.com.syngenta.${var.NameSpace}*/*"
          ]
      },
      {
        Sid = "DenyStatement"
        Action = [
          "s3:ReplicateTags",
          "s3:PutBucketWebsite",
          "s3:PutBucketPolicy",
          "s3:DeleteBucketPolic"
        ]
        Effect   = "Deny"
        Resource = "*"
      },
      {
        Sid = "AllowUseofCMK"
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${var.KMSKeyID}"
      },
      {
        Sid = "KMSUniversalAllow"
        Action = [
          "kms:ListKeys",
          "kms:ListAliases"
        ]
        Effect   = "Allow"
        Resource = "*"
      }

    ]
  })
}