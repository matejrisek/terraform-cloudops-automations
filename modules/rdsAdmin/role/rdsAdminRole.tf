resource "aws_iam_role" "rdsadmin_role" {
  name =  "rds_admin"
  description = "rds_admin"
  # Terraform",s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithSAML"
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:saml-provider/customer-saml"
        }
        Condition={
          StringLike = {
            "SAML:aud":"https://signin.aws.amazon.com/saml"
          }
        }
      },
    ]
  })

  tags = {
    Name = "rds_admin"
  }
}

resource "aws_iam_role_policy_attachment" "rdsadmin_role_RDSFullAccess_policy_attachment" {
  role       = aws_iam_role.rdsadmin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "rdsadmin_role_ReadOnlyAccess_policy_attachment" {
  role       = aws_iam_role.rdsadmin_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
resource "aws_iam_role_policy_attachment" "rdsadmin_cm_policy_attachment" {
  count =    length(var.customer_managed_policies_arns)
  role       = aws_iam_role.rdsadmin_role.name
  policy_arn = var.customer_managed_policies_arns[count.index]
}