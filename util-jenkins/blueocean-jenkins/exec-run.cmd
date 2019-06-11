docker run ^
  -u root ^
  -d ^
  -p 8181:8080 ^
  -p 50000:50000 ^
  -v /D/docker/jenkins/jenkins_home:/var/jenkins_home ^
  -v /D/docker/jenkins/home:/home ^
  -v /var/run/docker.sock:/var/run/docker.sock ^
  --name blueocean-jenkins ^
  pduleba/blueocean-jenkins:latest
