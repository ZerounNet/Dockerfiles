tee /entrypoint.sh <<EOF
QARC_WEBSERVER& 
QARC_Stock&
qaps_sub --exchange stocktransaction --model fanout --host \$EventMQ_IP
EOF
chmod a+x /entrypoint.sh
