FROM zerounnet/conda-base:latest

COPY wait_for_it.sh /

RUN apt-get update  && apt-get install gcc vim -y \
    && conda install fastcache -y \
    && pip install quantaxis_webserver quantaxis_pubsub qarealtime_collector \
    && echo 'QARC_WEBSERVER &' > /entrypoint.sh \
    && echo 'sleep 5' >> /entrypoint.sh \
    && echo '#qaps_sub --exchange stocktransaction --model fanout --host $EventMQ_IP &' >> /entrypoint.sh \
    && echo 'sleep 5' >> /entrypoint.sh \
    && echo 'QARC_Stock' >> /entrypoint.sh \
    && chmod u+x /entrypoint.sh /wait_for_it.sh \
    && conda clean -a -y && rm /root/.cache/ -rf  \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf 

CMD ["bash", "/entrypoint.sh"]

