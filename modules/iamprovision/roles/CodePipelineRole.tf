resource "aws_iam_role" "codepipeline_role" {
  name =  "${var.NameSpace}_${var.AccountEnv}_codepipeline_role"
  description = ",${var.NameSpace}_${var.AccountEnv}_codepipeline_role"
  # Terraform",s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = [
            "codepipeline.amazonaws.com",
            "events.amazonaws.com"
          ]

        }
      },
    ]
  })

  tags = {
    Name = "${var.NameSpace}_${var.AccountEnv}_codepipeline_role"
    Application= "${var.ApplicationName}"
    BusinessFunction ="${var.BusinessFunction}"
    ContactEmail ="${var.ContactEmail}"
    CostCenter= "${var.CostCenter}"
    Environment="${var.Environment}"
    OwnerEmail="${var.OwnerEmail}"
    Platform="${var.PlatformName}"

  }
}
resource "aws_iam_role_policy_attachment" "codepipeline_role_cm_policy_attachment" {
  count =    length(var.customer_managed_policies_arns)
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = var.customer_managed_policies_arns[count.index]
}