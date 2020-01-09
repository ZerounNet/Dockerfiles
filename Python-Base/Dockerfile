FROM ubuntu:18.04

COPY setup.sh ./

RUN export DEBIAN_FRONTEND=noninteractive \
    && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list  \
    && apt-get update  \
    && chmod u+x setup.sh && ./setup.sh && rm -rfv setup.sh \
    && ln -s /usr/local/conda/bin/conda /usr/local/bin/ \
    && ln -s /usr/local/conda/bin/pip /usr/local/bin/ \
    && ln -s /usr/local/conda/bin/python /usr/local/bin/ \
    && conda init bash \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && apt-get install apt-utils tzdata -y \
    && apt-get upgrade -y && apt-get autoremove -y \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf
