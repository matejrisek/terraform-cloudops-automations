variable "NameSpace" {
  type = string
#  default = "nsp"
}

variable "AccountEnv" {
  type = string
#  default = "nonprod"
}

variable "ApplicationName" {
  type = string
  default = "nps"

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
  default = "nonprod"
}

variable "OwnerEmail" {
  type = string
  default="trevor.jurgensen@syngenta.com"
}

variable "PlatformName" {
  type = string
  default = "nps"
}

# variable "AccountSubnet" {
#   type = string
#   default = "lz06_nonprod"
#   validation {
#     condition     = contains(["seeddevdt_nonprod_db_subnetgroup", "seeds-datalake-aurora-nonprod-subnet-group", "lz01_nonprod","lz02_nonprod","seedsrditlz03-nonprod-rdssubnetgroup","lz04-nonprod-database-subnet-group","lz05_nonprod","lz06_nonprod","lz07-nonprod","htp-prod","seeds-datalake-aurora-prod-subnet-group","lz01_prod","lz02_prod","lz03_prod_db_subnetgroup","lz04_prod","lz05_prod","seedsrdit_lz06_prod","lz07_prod"], var.AccountSubnet)
#     error_message = "Valid values for var: AccountSubnet should be in a given list."
#   }
# }
variable "KMSKeyID" {
  type = string
#  default = "kmsID"
}
variable "iam_profile" { type = string }
variable "region" {
  type = string
}

data "aws_caller_identity" "current" {}


# vars for
# custom SG

variable "vpcId" {
  type = string
}

variable "ingress_port_list" { type = list(string) }
