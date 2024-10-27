resource "aws_s3_bucket_lifecycle_configuration" "app-artifacts-lifecycle" {
  bucket = "${var.s3_prefix}.${var.env}"
  rule {
    id     = "clean-up"
    status = "Enabled"
    expiration {
      days = 3
    }
  }
}