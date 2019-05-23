# IaaC for `app-rest`

## Usage

* `exec\init-backend.bat` - Initialize Terraform `backend`
  * i.e. `call exec\init-backend.bat`
* `exec\init.bat MODULE ENV` - Initialize Terraform `MODULE` module using `ENV` environment specific configuration 
                                                                    with **initialized** Terraform backend
  * i.e. `call exec\init.bat vpc dev`
* `exec\apply.bat MODULE ENV` - Apply Terraform `MODULE` into **AWS** using `ENV` environment specific configuration 
                                                                      with **initialized** Terraform backend
  * i.e. `call exec\apply.bat vpc dev`
* `exec\destroy.bat MODULE ENV` - Destroy infrastructure in **AWS** using `ENV` environment specific configuration 
                                                                    with **initialized** Terraform backend
  * i.e. `call exec\destroy.bat vpc dev`

## Utils

* `exec\output.bat NAME` - Provides module output value by `NAME` or `all` module output values if not specified
  * i.e. `call exec\output.bat database_endpoint`

* `exec\apply-plan.bat MODULE ENV` - Provides apply plan file
  * i.e. `call exec\apply-plan.bat vpc dev`
* `exec\destroy-plan.bat MODULE ENV` - Provides destroy plan file
  * i.e. `call exec\destroy-plan.bat vpc dev`

* `exec\session\start.bat LOG_FILE_NAME` - Utility :: Starts execution recording
* `exec\session\stop.bat` - Utility :: Stops execution recording


## Documentation
* [Terraform](https://www.terraform.io/docs/index.html)