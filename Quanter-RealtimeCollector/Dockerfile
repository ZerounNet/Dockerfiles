FROM zerounnet/python-base:latest

COPY setup.sh ./

RUN apt-get update \
    && apt-get install gcc supervisor dumb-init -y \
    && pip install quantaxis_webserver quantaxis_pubsub qarealtime_collector \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf \
    && rm rm /root/.cache/ -rf \ 
    && chmod u+x setup.sh && ./setup.sh && rm -rfv setup.sh

CMD ['bash', '/entrypoint.sh']
