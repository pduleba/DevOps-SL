# IaaC for `app-rest`

## Usage

* `exec-init.bat` - Initialize Terraform
* `exec-apply.bat` - Deploy infrastructure into **AWS**
* `exec-destroy.bat` - Destroy infrastructure in **AWS**

## Utils

* `utils/exec-plan-apply.bat` - Calculate plan for `terraform apply` using available available state 
* `utils/exec-plan-destroy.bat` - Calculate plan for `terraform destroy` using available available state 
* `utils/exec-refresh.bat` - Refresh Terraform state file
* `utils/exec-cleanup.bat` - Removes non project files

## Documentation
* [Terraform](https://www.terraform.io/docs/index.html)