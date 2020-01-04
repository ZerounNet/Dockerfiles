FROM ubuntu:18.04

RUN export DEBIAN_FRONTEND=noninteractive \
    && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && apt-get update && apt-get install nginx dumb-init git -y \
    && apt-get upgrade -y && apt-get autoremove -y \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf \
    && rm /var/www/html/* -rf \
    && git clone https://gitee.com/yutiansut/QADESK_BASIC /var/www/html

COPY setup.sh /

RUN chmod a+x /setup.sh && /setup.sh && rm /setup.sh

CMD ["bash", "/entrypoint.sh"]
