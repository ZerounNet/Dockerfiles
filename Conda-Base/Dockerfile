FROM ubuntu:18.04

COPY .condarc /usr/local/conda/.condarc

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8 \
    PATH="/usr/local/conda/bin:/usr/local/conda/condabin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    SHELL=/bin/bash \
    TERM=xterm-256color

RUN export DEBIAN_FRONTEND=noninteractive \
    && wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /Miniconda3-latest-Linux-x86_64.sh -b -p /usr/local/conda \
    && rm /Miniconda3-latest-Linux-x86_64.sh \
    && ln -s /usr/local/conda/.condarc  /root \
    && conda install -n base python==3.6.9 -y \
    && conda update -n base conda -y \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list  \
    && apt-get update  && apt-get install wget apt-utils tzdata locales -y \
    && locale-gen zh_CN.UTF-8 \
    && conda clean -a -y && rm /root/.cache/ -rf  \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf

