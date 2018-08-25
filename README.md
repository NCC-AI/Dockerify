# Dockerify
Build Docker Container on Deep Learning Box 

## Mac側の設定(DLB, Dockerに簡単接続)  
公開鍵、秘密鍵の作成
```
$ ssh-keygen -t rsa -f key_name -C test@example.com
e.g.) $ ssh-keygen -t rsa -f my_key -C 1234defgsigeru@gmail.com
```

DLBに公開鍵を送る
```
$ chmod 600 key_name
$ scp -P 3030 key_name.pub hiroki@121.2.124.147:~/.ssh/authorized_keys
$ vim ~/.ssh/config
```

2段階SSHのための設定
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

NCCのDLB1(外部接続してる方)に接続  
`ssh _ncc1-dl`

sshのpassを登録  
`ssh-add ~/.ssh/id_rsa`
再起動しても消えないように登録  
`ssh-add -K ~/.ssh/id_rsa`

## Docker環境構築手順
- [ ] Dockerfileの自分のアカウントのauthorized_keysをセットする

```
$ sh install-nvidia-docker.sh
$ sh docker_start.sh
```

## DLB内でよく使うコマンド

docker から抜ける  
`$ exit`  

docker に入る
```
$ sudo nvidia-docker exec -it ncc1-docker /bin/bash
```

MacからDLB1のDockerに接続  
`ssh ncc1-docker`