FROM codercom/code-server:v2
FROM zerounnet/phper-base:latest

COPY --from=0 /usr/local/bin/code-server /usr/local/bin/code-server

COPY setup.sh /home/phper
COPY extensions /home/phper/.local/share/code-server/extensions

RUN apt-get update && apt-get install -y fonts-wqy-microhei bash-completion screen supervisor openssl net-tools git locales sudo dumb-init vim curl \
    && adduser --gecos '' --disabled-password phper \
    && echo "phper ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd \
    && mkdir -p /home/phper/project \
    && chown -R phper:phper /home/phper \
    && sudo -H -u phper composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && chmod u+x /home/phper/setup.sh && /home/phper/setup.sh && rm /home/phper/setup.sh \
    && chmod a+x /home/phper/entrypoint.sh && chown root:root /home/phper/entrypoint.sh \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf

USER phper
WORKDIR /home/phper/project

CMD ["bash", "/home/phper/entrypoint.sh"]