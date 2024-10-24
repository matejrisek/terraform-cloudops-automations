
#   https://digitial-product-engineering.atlassian.net/browse/SRSO-312


module policiy{
  source="./policy"
  AccountEnv = var.AccountEnv
 }

module roles {
  source="./role"
  customer_managed_policies_arns =module.policiy.customer_managed_policies_arns
  depends_on = [module.policiy]
}

