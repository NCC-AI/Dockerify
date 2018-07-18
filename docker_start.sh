sudo docker build -t anaconda-docker .
sudo docker run -id --rm -p 6533:22 --name nccy-docker anaconda-docker
