

variable "AccountEnv" {
  type = string
  default = "nonprod"
  validation {
    condition     = contains(["nonprod","prod"], var.AccountEnv)
    error_message = "Valid values for var: AccountEnv should be in prod or nonprod."
  }
}



data "aws_region" "current" {}
data "aws_caller_identity" "current" {}