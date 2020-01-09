FROM zerounnet/quanter-base:latest

RUN apt-get update && apt-get install -y fonts-wqy-microhei bash-completion screen supervisor openssl net-tools git locales sudo dumb-init vim curl \
    && adduser --gecos '' --disabled-password quanter \
    && echo "quanter ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd \
    && sed -i 's/secure_path=\"/secure_path=\"\/usr\/local\/conda\/bin:\/usr\/local\/conda\/condabin:/g' /etc/sudoers \
    && echo "PATH=\"$PATH\"" > /etc/environment \
    && ln -s /usr/share/fonts/truetype/wqy/wqy-microhei.ttc /usr/local/conda/lib/python3.6/site-packages/matplotlib/mpl-data/fonts/ttf/ \
    && conda clean -a -y && rm /root/.cache/ -rf  \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf

USER quanter
COPY setup.sh /home/quanter

RUN mkdir -p /home/quanter/project \
    && ln -s /usr/local/conda/.condarc ~/ \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && sudo chown -R quanter:quanter /home/quanter \
    && chmod u+x /home/quanter/setup.sh && /home/quanter/setup.sh && rm /home/quanter/setup.sh \
    && sudo chmod a+x /home/quanter/entrypoint.sh && sudo chown root:root /home/quanter/entrypoint.sh 

WORKDIR /home/quanter/project

CMD ["bash", "/home/quanter/entrypoint.sh"]
