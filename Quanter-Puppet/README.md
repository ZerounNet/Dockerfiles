# 系统说明
* 这是一个QUANTAXIS和PUPPET集成环境的部署文档。
* 在部署集成环境之前，请确保已经具备独立完成初始化环境所需的技能
# 部署准备
## 初始化环境
* Linux操作系统，包括但不仅限于Ubuntu、CentOS。
* 完成KVM的安装，准备好win7/win10操作系统ISO。
* 完成Docker的安装，并安装docker-compose支持。
# 部署过程
* sudo mkdir /home/docker/Mount/quantaxis/code /home/docker/Mount/quantaxis/mgdb /home/docker/Mount/samba -p