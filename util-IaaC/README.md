# IaaC for `app-rest`

## Usage

* `exec\win\init MODULE ENV` - Initialize Terraform `MODULE` module using `ENV` environment specific configuration 
  * i.e. `call exec\win\init vpc dev`
* `exec\win\apply MODULE ENV` - Apply Terraform `MODULE` into **AWS** using `ENV` environment specific configuration 
  * i.e. `call exec\win\apply vpc dev`
* `exec\win\destroy MODULE ENV` - Destroy infrastructure in **AWS** using `ENV` environment specific configuration 
  * i.e. `call exec\win\destroy vpc dev`

## Utils

* `exec\win\output NAME` - Provides module output value by `NAME` or `all` module output values if not specified
  * i.e. `call exec\win\output backend_bucket`

* `exec\win\apply-plan MODULE ENV` - Provides apply plan file
  * i.e. `call exec\win\apply-plan vpc dev`
* `exec\win\destroy-plan MODULE ENV` - Provides destroy plan file
  * i.e. `call exec\win\destroy-plan vpc dev`

* `exec\win\session\start LOG_FILE_NAME STATE_MODE OUTPUT_MODE` - Utility :: Starts execution recording
* `exec\win\session\stop` - Utility :: Stops execution recording

## Documentation
* [Terraform](https://www.terraform.io/docs/index.html)