FROM codercom/code-server:v2
FROM zerounnet/quanter-notebook:latest

COPY --from=0 /usr/local/bin/code-server /usr/local/bin/code-server

USER coder

COPY setup.sh /home/coder
COPY extensions /home/coder/.local/share/code-server/extensions

RUN sudo chown -R coder:coder /home/coder/.local \
    && sudo chmod a+x /home/coder/setup.sh && /home/coder/setup.sh && sudo rm /home/coder/setup.sh
