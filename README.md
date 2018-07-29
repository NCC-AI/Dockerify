# Dockerify
Build Docker Container on Deep Learning Box 

## 環境構築手順

```
$ sh install-nvidia-docker.sh
$ sh docker_start.sh
```

## よく使うコマンド

docker から抜ける  
`$ exit`  

docker に入る
```
$ sudo nvidia-docker exec -it ncc1-docker /bin/bash
```

TODO : 2段階sshを一発で行う(プロキシコマンド)   
(自宅~>NCCのDLにssh~>Dockerにssh)
