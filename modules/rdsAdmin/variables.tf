

variable "AccountEnv" {
  type = string
#  default = "nonprod"
}

data "aws_caller_identity" "current" {}