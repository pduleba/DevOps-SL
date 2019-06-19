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

* `exec\win\utils\get-parameters ENV` - Read SSM parameters value by `ENV` environment
    **MANY PER REQUEST**
  * i.e. on Linux
    * `out=$(exec/ux/utils/get-parameters.sh dev)` - get all
    * `exec/ux/utils/find-parameter.sh host <<< $out` - find specific value
  * i.e. on Windows
    * `exec\win\utils\get-parameters dev > json` - get all
    * `exec\win\utils\find-parameter host < json` - find specific value

* `exec\win\utils\get-parameter NAME ENV` - Read SSM parameter value by `NAME` under `ENV` environment, 
    **ONE PER REQUEST**
  * i.e. `exec/ux/utils/get-parameter.sh database/host dev`
  * i.e. `exec\win\utils\get-parameter database/host dev`
  * available parameter can be found in `config\env\ENV\*.tfvars`

* `exec\[win/ux]\utils\session-start MODULE ENV LOG_NAME` - Utility :: Starts execution recording
* `exec\[win/ux]\utils\session-stop` - Utility :: Stops execution recording

* Accessing instance via Bastion
  * `ps aux | grep -v grep | grep ssh-agent` - verify if `ssh-agent` is already running
  * `eval ``ssh-agent`` ` - start `ssh-agent`
  * `ssh-add -k key.pem` - add your PEM key
  * `ssh-add -L` - list added keys
  * Connect via Bastion
    * `ssh -At user@bastion-ip -i key.pem` + `ssh user@private-ip` - connect using `ssh` via `bastion-ip` to `private-ip`
    * `ssh -At user@bastion-ip ssh user@private-ip` - similar but one command
  * Copy via Bastion
    * `scp -i key.pem -o ProxyCommand="ssh user@bastion-ip nc private-ip 22" package.zip user@private-ip:~/` - copy using `scp` via `bastion-ip` to `private-ip`
      * `nc` command must be installed on Bastion!

## Documentation
* [Terraform](https://www.terraform.io/docs/index.html)
* [About ssh-agent and ssh-add in Unix](https://kb.iu.edu/d/aeww)
* [Securely Connect to Linux Instances Running in a Private Amazon VPC](https://aws.amazon.com/blogs/security/securely-connect-to-linux-instances-running-in-a-private-amazon-vpc/)
* [Connect To The Application Instance Using SSH](https://docs.bitnami.com/aws-templates/infrastructure/lamp-production-ready/get-started/connect-ssh/)