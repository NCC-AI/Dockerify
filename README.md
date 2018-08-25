# Dockerify
Build Docker Container on Deep Learning Box 

## 環境構築手順
- [ ] Dockerfileの自分のアカウントのauthorized_keysをセットする

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

## Mac側の設定(DLB, Dockerに簡単接続)

```
$ ssh-keygen -t rsa -f my_key -C test@example.com
$ chmod 600 my_key
$ scp -P 3030 my_key.pub hiroki@121.2.124.147:~/.ssh
$ vim ~/.ssh/config
```

```bash ~/.ssh/config
Host _ncc1-dl
  User hiroki
  Port 3030
  Hostname 121.2.124.147
  IdentityFile ~/.ssh/mykey
  TCPKeepAlive yes
  IdentitiesOnly yes

Host ncc1-docker
  User hiroki
  Port 8567
  Hostname 127.0.0.1
  IdentityFile ~/.ssh/mykey
  TCPKeepAlive yes
  IdentitiesOnly yes
  ProxyCommand ssh -W %h:%p _ncc1-dl
  StrictHostKeyChecking no
```

- NCCのDLB1(外部接続してる方)に接続  
`ssh _ncc1-dl`

- DLB1のDockerに接続  
`ssh ncc1-docker`

sshのpassを登録  
`ssh-add ~/.ssh/id_rsa`
再起動しても消えないように登録  
`ssh-add -K ~/.ssh/id_rsa`
