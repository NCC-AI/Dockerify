# Docker

# 念のため古いバーションのリムーヴ
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
# 依存パッケージのインストール
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
# Docker公式のGPG keyを追加
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# stable repositoryを登録
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
# 現在のnvidia dockerと互換の中で最新のversionのdockerを入れる
sudo apt-get install docker-ce=17.03.2~ce-0~ubuntu-xenial

# Nvidia-Docker

# If you have nvidia-docker 1.0 installed: we need to remove it and all existing GPU containers
docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo apt-get purge -y nvidia-docker

# Add the package repositories
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

# Install nvidia-docker2 and reload the Docker daemon configuration
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd

# Test nvidia-smi with the latest official CUDA image
sudo docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
