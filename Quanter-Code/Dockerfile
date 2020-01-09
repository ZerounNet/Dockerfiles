FROM codercom/code-server:v2
FROM zerounnet/quanter-jupyter:latest

COPY --from=0 /usr/local/bin/code-server /usr/local/bin/code-server
COPY setup.sh /home/quanter
COPY extensions /home/quanter/.local/share/code-server/extensions

RUN sudo chown -R quanter:quanter /home/quanter/.local \
    && sudo chmod a+x /home/quanter/setup.sh && /home/quanter/setup.sh && sudo rm /home/quanter/setup.sh
