:: Expose port 3306 so you will be able to connect to MySQL docker container from outside (Host OS)
docker run ^
  -d ^
  -p 3306:3306 ^
  --name app-db ^
  pduleba/app-db:latest
