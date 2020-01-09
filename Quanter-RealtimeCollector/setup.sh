tee /entrypoint.sh <<EOF
sleep 15
QARC_WEBSERVER& 
sleep 5
QARC_Stock&
sleep 5
qaps_sub --exchange stocktransaction --model fanout --host \$EventMQ_IP
EOF
chmod a+x /entrypoint.sh
