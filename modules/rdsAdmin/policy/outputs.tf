output "customer_managed_policies_arns" {
  value = [
    aws_iam_policy.SecretsManagerPolicy.arn
  ]

}