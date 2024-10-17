This terraform was used for provision roles and policies automatically when provison a new namespace in MLAZ to replace the old CloudFormation scripts
how to use it?
Step 1: clean the local lock and cachec provider and modules foldr in .terraform and .terraform.lock.hcl
Step 2. use https://digitial-product-engineering.atlassian.net/wiki/spaces/AWSMA/pages/593854552/AWS+CLI+Configuration+with+SAML+for+Syngenta+Windows+Client
Conifg and login your profile for the aws credntials
Step 3: modify the terraform.tfvars make sure your value for variavles are correct to your work

NameSpace: namespace code that is in provisioning

AccountSubnet = account Subnet used for RDS, must in cloudops's given list

KMSKeyID :ksmkey id you created for this namespace.

iam_profile:the credentials name used to exec the apply or destroy command in the future.
Note that iam_profile is the profile name that provide the credentials for the running.
Step 4: make suer your backet and path to store the tfstat file.
Step 5 init the terroform use
terraform init -input=false --backend-config=dev.config -backend-config="key=terraform/dh-iam/terraform.tfstate" -backend-config="bucket=us.com.syngenta.seedsrdit-cloudops-03-prod" -backend-config="profile=1042-lz03-prod"

key: is the path inside bucket.

bucket: bucket used to stor statefile

profile: the credentials name used to exec the init command.

terraform plan -var-file=vars/prod.tfvars

Please modify the value of bucket,key, and profile accordingly.
Note that bucket is the bucket used to store the backend status of terraform. and the key is the path of statae file in the bucket, profile is the credentials name you are using
terraform apply  -var-file=vars/prod.tfvars -auto-approve
Step 6 apply the resources by run terraform apply '-input=false'  -auto-approve

terraform destroy  -var-file=terraform.tfvars -auto-approve
