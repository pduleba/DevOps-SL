# Jenkins Utils

## Documentation
* `blueocean-jenkins` - creates Jenkins server using `pduleba/blueocean-edge` image (see `blueocean-edge`)
* `blueocean-edge` - contains refreshed version of `jenkinsci/blueocean:latest` Docker image 
* `blueocean-agent` - contains docker image used Jenkinsfile `docker` agent

## Available tools
* `exec-build.bat` - executes `docker build` 
* `exec-run.bat` - executes `docker run` 
* `exec-connect.bat` - executes `docker exec -it` 
* `exec-push.bat` - executes `docker push` (require `docker login`)

## Documentation
* [Terraform](https://www.terraform.io/docs/index.html)