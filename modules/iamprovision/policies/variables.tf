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

variable "KMSKeyID" {
  type = string
  default = "abc"
}

variable "AccountSubnet" {
  type = string
  default = "lz06_nonprod"
  validation {
    condition     = contains(["seeddevdt_nonprod_db_subnetgroup", "seeds-datalake-aurora-nonprod-subnet-group", "lz01_nonprod","lz02_nonprod","seedsrditlz03-nonprod-rdssubnetgroup","lz04-nonprod-database-subnet-group","lz05_nonprod","lz06_nonprod","lz07-nonprod","htp-prod","seeds-datalake-aurora-prod-subnet-group","lz01_prod","lz02_prod","lz03_prod_db_subnetgroup","lz04_prod","lz05_prod","seedsrdit_lz06_prod","lz07_prod","seeds_euc1_lz03_prod","seeds_euc1_lz03_nonprod","seedsdl_nonprod_db_subnetgroup","seedsdl_cicd_db_subnetgroup","cicl_prod_db_subnetgroup","htp-prod","iot-prod","iot-nonprod"], var.AccountSubnet)
    error_message = "Valid values for var: AccountSubnet should be in a given list."
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}