# 系统说明
* 这是一个QUANTAXIS和PUPPET集成环境的部署文档。
* 在部署集成环境之前，请确保已经具备独立完成初始化环境所需的技能
# 部署准备
## 初始化环境
1) Linux操作系统，包括但不仅限于Ubuntu、CentOS。
2) 完成KVM的安装，准备好win7/win10操作系统ISO。
3) 完成Docker的安装，并安装docker-compose支持。
# 部署过程
## 实体机
* 为docker和kvm的建立网络链接
```
sudo docker network create --driver=bridge --subnet=192.168.100.0/24 docker-kvm
```
* 为docker的数据建立和配置持久化存储空间
```
sudo mkdir -p /home/docker/Mount/quantaxis/code 
sudo mkdir -p /home/docker/Mount/quantaxis/mgdb
sudo mkdir -p /home/docker/Mount/samba
```
未完待续...