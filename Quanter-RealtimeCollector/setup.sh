docker run -it --rm -e LANG=C.UTF-8 -e MONGODB=192.168.100.2 -e EventMQ_IP=192.168.100.3 ubuntu:18.04 bash
docker run -it --rm -e LANG=C.UTF-8 -e MONGODB=192.168.100.2 -e EventMQ_IP=192.168.100.3 zerounnet/quanter-base:latest bash


拉起镜像
docker run -it --rm -e LANG=C.UTF-8 -e MONGODB=192.168.100.2 -e EventMQ_IP=192.168.100.3 ubuntu:18.04 bash

镜像内运行：
sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list 
apt-get update
apt-get install python3-pip -y
pip3 install -U pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install quantaxis_webserver quantaxis_pubsub qarealtime_collector

执行
QARC_WEBSERVER
QARC_Stock
qaps_sub --exchange stocktransaction --model fanout --host 192.168.100.3
