docker run ^
  -u root ^
  --rm ^
  -d ^
  -p 8181:8080 ^
  -p 50000:50000 ^
  -v D:/work-pduleba/repo/DevOps-SL/util-IaaC/exec:/var/jenkins_home/util-IaaC/exec ^
  --name util-jenkins ^
  util-jenkins:latest
