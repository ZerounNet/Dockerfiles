FROM zerounnet/quanter-base:latest

RUN mkdir /tmp/usr/include /tmp/usr/lib -p \
    && cp -rv /usr/include/ta-lib /tmp/usr/include \
    && cp -rv /usr/lib/libta_lib* /tmp/usr/lib

FROM codercom/code-server:v2

FROM ubuntu:18.04

COPY --from=0 /tmp/usr /usr
COPY --from=0 /usr/local/conda /usr/local/conda
COPY --from=1 /usr/local/bin/code-server /usr/local/bin/code-server

RUN export DEBIAN_FRONTEND=noninteractive \
    && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && apt-get update && apt-get install apt-utils tzdata fonts-wqy-microhei bash-completion -y \
    && apt-get install -y \
        openssl \
        net-tools \
        git \
        locales \
        sudo \
        dumb-init \
        vim \
        curl \
        wget \
    && apt-get upgrade -y && apt-get autoremove -y \
    && apt-get clean -y && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf \
    && TZ=Asia/Shanghai && LANG=zh_CN.UTF-8 && locale-gen zh_CN.UTF-8 && SHELL=/bin/bash \
    && adduser --gecos '' --disabled-password coder \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd \
    && /usr/local/conda/bin/conda init bash && ln -s /usr/local/conda/.condarc ~/ \
    && /usr/local/conda/bin/pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && ln -s /usr/share/fonts/truetype/wqy/wqy-microhei.ttc /usr/local/conda/lib/python3.6/site-packages/matplotlib/mpl-data/fonts/ttf/

USER coder

COPY setup.sh /home/coder
COPY extensions /home/coder/.local/share/code-server/extensions

RUN mkdir -p /home/coder/project \
    && /usr/local/conda/bin/conda init bash && ln -s /usr/local/conda/.condarc ~/ \
    && /usr/local/conda/bin/pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && sudo chown -R coder:coder /home/coder \
    && chmod a+x /home/coder/setup.sh && /home/coder/setup.sh && rm /home/coder/setup.sh \
    && sudo chown root:root /home/coder/entrypoint.sh 

WORKDIR /home/coder/project

CMD ["bash", "/home/coder/entrypoint.sh"]
