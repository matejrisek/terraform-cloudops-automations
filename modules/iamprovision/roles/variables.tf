variable "NameSpace" {
  type = string
  default = "nsp"
}

variable "AccountEnv" {
  type = string
  default = "nonprod"
  validation {
    condition     = contains(["nonprod","prod"], var.AccountEnv)
    error_message = "Valid values for var: AccountEnv should be in prod or nonprod."
  }
}

variable "ApplicationName" {
  type = string
  default = "nsp"
}

variable "BusinessFunction" {
  type = string
  default = "Seeds R+D"
}

variable "ContactEmail" {
  type = string
  default = "arthur.yang@syngenta.com"
}

variable "CostCenter" {
  type = string
  default = "RDIT3000"
}
variable "Environment" {
  type = string
  default = "sbx"
}

variable "OwnerEmail" {
  type = string
  default = "trevor.jurgensen@syngenta.com"
}

variable "PlatformName" {
  type = string
  default = "nsp"
}

data "aws_caller_identity" "current" {}
variable "customer_managed_policies_arns" {
  type = list(string)
}