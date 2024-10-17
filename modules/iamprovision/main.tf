
#   https://digitial-product-engineering.atlassian.net/browse/SRSO-312
locals {
  db_account_subnet_group_map ={
    "846923534607":"seeddevdt_nonprod_db_subnetgroup",
    "375543164207":"lz01_nonprod",
    "090785149484":"lz02_nonprod",
    "407813124837":"seedsrditlz03-nonprod-rdssubnetgroup",
    "380723925535":"lz04-nonprod-database-subnet-group",
    "771826826527":"lz05_nonprod",
    "809800841141":"lz06_nonprod",
    "898196863090":"lz07-nonprod",
    "617237291810":"seeds-datalake-aurora-prod-subnet-group",
    "125881442796":"lz01_prod",
    "172673116292":"lz02_prod",
    "161004221042":"lz03_prod_db_subnetgroup",
    "763466225947":"lz04_prod",
    "240705227245":"lz05_prod",
    "750606694809":"seedsrdit_lz06_prod",
    "500838610184":"lz07_prod",
    "851725260008":"seeds_euc1_lz03_prod",
    "891376945255":"seeds_euc1_lz03_nonprod",
    "473721753516":"seedsdl_nonprod_db_subnetgroup",
    "462727384747":"seedsdl_cicd_db_subnetgroup",
    "357946278592":"cicl_prod_db_subnetgroup",
    "617237291810":"htp-prod",
    "678574114107":"iot-prod",
    "316742306005":"iot-nonprod"


  }
}

module policies{
  source="./policies"
  NameSpace = var.NameSpace
  AccountEnv = var.AccountEnv
  KMSKeyID= var.KMSKeyID
  AccountSubnet=lookup(local.db_account_subnet_group_map, data.aws_caller_identity.current.account_id, "default db_subnet_group")
}

module roles {
  source="./roles"

  NameSpace = var.NameSpace
  AccountEnv = var.AccountEnv
  ApplicationName = var.ApplicationName
  BusinessFunction = var.BusinessFunction
  ContactEmail = var.ContactEmail
  CostCenter = var.CostCenter
  Environment = var.Environment
  OwnerEmail = var.OwnerEmail
  PlatformName = var.PlatformName
  customer_managed_policies_arns =module.policies.customer_managed_policies_arns
  depends_on = [module.policies]
}

