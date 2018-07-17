sudo docker build -t anaconda-docker ./Dockerfile
sudo docker run -id --rm -p 6433:22 --name nccy-docker anaconda-docker
