sudo nvidia-docker build -t anaconda-docker .
sudo nvidia-docker run --rm -i -t -d -p 8567:22 --name ncc1-docker anaconda-docker /bin/bash

# login docker
sudo nvidia-docker exec -it ncc1-docker /bin/bash
