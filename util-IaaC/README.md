# IaaC for `app-rest`

## Usage

* `exec\init-backend` - Initialize Terraform `backend`
  * i.e. `call exec\init-backend`
* `exec\init MODULE ENV` - Initialize Terraform `MODULE` module using `ENV` environment specific configuration 
                                                                    with **initialized** Terraform backend
  * i.e. `call exec\init vpc dev`
* `exec\apply MODULE ENV` - Apply Terraform `MODULE` into **AWS** using `ENV` environment specific configuration 
                                                                      with **initialized** Terraform backend
  * i.e. `call exec\apply vpc dev`
* `exec\destroy MODULE ENV` - Destroy infrastructure in **AWS** using `ENV` environment specific configuration 
                                                                    with **initialized** Terraform backend
  * i.e. `call exec\destroy vpc dev`

## Utils

* `exec\output NAME` - Provides module output value by `NAME` or `all` module output values if not specified
  * i.e. `call exec\output database_endpoint`

* `exec\apply-plan MODULE ENV` - Provides apply plan file
  * i.e. `call exec\apply-plan vpc dev`
* `exec\destroy-plan MODULE ENV` - Provides destroy plan file
  * i.e. `call exec\destroy-plan vpc dev`

* `exec\session\start LOG_FILE_NAME` - Utility :: Starts execution recording
* `exec\session\stop` - Utility :: Stops execution recording


## Documentation
* [Terraform](https://www.terraform.io/docs/index.html)