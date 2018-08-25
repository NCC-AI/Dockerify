# Dockerify
_Build Docker Container on Deep Learning Box_  
*最終ゴール*  
Macから公開鍵SSHで
1. `ssh _ncc1-dl` でNCCのDeep Learning Boxに接続
1. `ssh ncc1-docker` でDLBのDockerに接続する

## Mac側の設定(DLB, Dockerに簡単接続)  
公開鍵、秘密鍵の作成
```bash
($ mkdir ~/.ssh なければ作る)
$ cd ~/.ssh
$ ssh-keygen -t rsa -f KeyName -C test@example.com
e.g. $ ssh-keygen -t rsa -f my_key -C 1234defgsigeru@gmail.com
```

DLBに公開鍵を送る
```bash
$ chmod 600 my_key
$ scp -P 3030 my_key.pub hiroki@121.2.124.147:~/.ssh/authorized_keys
$ vim ~/.ssh/config
```

2段階SSHのための設定
```bash ~/.ssh/config
Host _ncc1-dl
  User hiroki
  Port 3030
  Hostname 121.2.124.147
  IdentityFile ~/.ssh/my_key
  TCPKeepAlive yes
  IdentitiesOnly yes

Host ncc1-docker
  User hiroki
  Port 8567
  Hostname 127.0.0.1
  IdentityFile ~/.ssh/my_key
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

## Docker環境構築手順(DLB内で作業)

nvidia-dockerをインストールしてない場合は以下
```bash
$ sh install-nvidia-docker.sh
```

- [ ] *Dockerfile*で自分のアカウントのauthorized_keysをセットしてから、
以下のコマンド実行
```bash
$ sh docker_start.sh
```

## DLB内でよく使うコマンド

docker から抜ける  
`$ exit`  

docker に入る
```bash
$ sudo nvidia-docker exec -it ncc1-docker /bin/bash
```

## MacからDLB1のDockerに接続  
`ssh ncc1-docker`