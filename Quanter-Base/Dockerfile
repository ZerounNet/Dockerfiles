FROM ubuntu:18.04

RUN export DEBIAN_FRONTEND=noninteractive \
    && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && apt-get update && apt-get upgrade -y && apt-get autoremove -y \
    && apt-get install apt-utils tzdata wget -y \
    && wget https://raw.githubusercontent.com/ZerounNet/Dockerfiles/master/Quanter-Base/setup.sh \
    && chmod u+x setup.sh && ./setup.sh && rm -rfv setup.sh \
    && apt-get clean -y && rm /tmp/* -rf && rm /root/.cache/ -rf && rm /var/lib/apt/lists/* -rf

CMD ["bash", "/entrypoint.sh"]