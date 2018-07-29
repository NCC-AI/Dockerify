sudo nvidia-docker build -t anaconda-docker .
sudo nvidia-docker run -id --rm -p 6533:22 --name nccy-docker anaconda-docker
