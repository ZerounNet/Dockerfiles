FROM zerounnet/phper-base:latest

COPY copy /tmp/phper

RUN apt-get update \
    && apt-get install -y supervisor dumb-init \
	&& mkdir /run/php /var/lib/www -p \
	&& chmod a+x /tmp/phper/setup.sh \
	&& /tmp/phper/setup.sh \
	&& chmod u+x /root/entrypoint.sh \
	&& apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf

CMD ["bash", "/root/entrypoint.sh"]