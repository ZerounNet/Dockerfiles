FROM ubuntu:18.04

COPY setup.sh /

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8 \
    PATH="/usr/local/conda/bin:/usr/local/conda/condabin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    SHELL=/bin/bash \
    TERM=xterm-256color

RUN export DEBIAN_FRONTEND=noninteractive \
    && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list  \
    && apt-get update  \
    && chmod u+x /setup.sh && /setup.sh && rm -rfv /setup.sh \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && apt-get install apt-utils tzdata locales -y \
    && locale-gen zh_CN.UTF-8 \
    && apt-get upgrade -y && apt-get autoremove -y \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf

