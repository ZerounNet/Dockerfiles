tee  /home/coder/entrypoint.sh > /dev/null <<EOF
sudo cp -f /etc/supervisor/supervisord.conf.bak /etc/supervisor/supervisord.conf
echo "environment=TZ='\$TZ',LANG='\$LANG'" | sudo tee -a /etc/supervisor/supervisord.conf
sudo dumb-init supervisord -n -c /etc/supervisor/supervisord.conf
EOF


tee /etc/supervisor/supervisord.conf.bak > /dev/null <<EOF
[unix_http_server]
file=/var/run/supervisor.sock
chmod=0700

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run/supervisor.sock

[include]
files = /etc/supervisor/conf.d/*.conf

[supervisord]
logfile=/var/log/supervisor/supervisord.log
pidfile=/var/run/supervisord.pid
childlogdir=/var/log/supervisor
EOF

tee /home/coder/.local/share/code-server/coder.json > /dev/null <<EOF
{"lastVisited":{"path":"/home/phper/project","workspace":false}}
EOF

tee /etc/supervisor/conf.d/code.conf > /dev/null <<EOF
[program:code]
command=dumb-init code-server --host=0.0.0.0 --port=8887 --auth=none
user=phper
startsecs=0
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
EOF

sudo -u phper -H /home/phper composer config -g repo.packagist composer https://packagist.phpcomposer.com
