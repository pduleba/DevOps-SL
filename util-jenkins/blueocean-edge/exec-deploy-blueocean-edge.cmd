docker build -t blueocean-edge:latest -f Dockerfile-blueocean-edge .
docker tag blueocean-edge:latest pduleba/blueocean-edge:latest
docker push pduleba/blueocean-edge