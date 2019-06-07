# IaaC for `app-rest`

## Usage

* `exec\win\init MODULE ENV` - Initialize Terraform `MODULE` module using `ENV` environment specific configuration 
  * i.e. `exec/ux/init.sh network dev`
  * i.e. `exec\win\init network dev`
* `exec\win\apply-plan MODULE ENV` - Provides apply plan file
  * i.e. `exec/ux/apply-plan.sh network dev`
  * i.e. `exec\win\apply-plan network dev`
* `exec\win\apply MODULE ENV` - Apply Terraform `MODULE` into **AWS** using `ENV` environment specific configuration 
  * i.e. `exec/ux/apply.sh network dev`
  * i.e. `exec\win\apply network dev`
* `exec\win\destroy-plan MODULE ENV` - Provides destroy plan file
  * i.e. `exec/ux/destroy-plan.sh network dev`
  * i.e. `exec\win\destroy-plan network dev`
* `exec\win\destroy MODULE ENV` - Destroy infrastructure in **AWS** using `ENV` environment specific configuration 
  * i.e. `exec/ux/destroy.sh network dev`
  * i.e. `exec\win\destroy network dev`
  
## Utils

* `exec\win\utils\output MODULE NAME` - Provides module output value by `NAME` or `all` module output values if not 
specified
  * i.e. `exec/ux/utils/output.sh backend backend_bucket`
  * i.e. `exec\win\utils\output backend backend_bucket`
  
* `exec\win\utils\get-parameter NAME ENV` - Read SSM parameter value by `NAME` under `ENV` environment
  * i.e. `exec/ux/utils/get-parameter.sh database/host dev`
  * i.e. `exec\win\utils\get-parameter database/host dev`
  * available parameter can be found in `config\env\ENV\*.tfvars`

* `exec\[win/ux]\utils\session-start MODULE ENV LOG_NAME` - Utility :: Starts execution recording
* `exec\[win/ux]\utils\session-stop` - Utility :: Stops execution recording

## Documentation
* [Terraform](https://www.terraform.io/docs/index.html)