docker run ^
  -u root ^
  -d ^
  -p 8181:8080 ^
  -p 50000:50000 ^
  -v D:/work-pduleba/repo/DevOps-SL/util-IaaC/exec:/var/jenkins_home/util-IaaC/exec ^
  --name blueocean-jenkins ^
  pduleba/blueocean-jenkins:latest
