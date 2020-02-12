tee  /root/entrypoint.sh > /dev/null <<EOF
cp -f /etc/supervisor/supervisord.conf.bak /etc/supervisor/supervisord.conf
echo "environment=TZ='\$TZ',LANG='\$LANG'" | tee -a /etc/supervisor/supervisord.conf
dumb-init supervisord -n -c /etc/supervisor/supervisord.conf
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



tee /etc/supervisor/conf.d/php.conf > /dev/null <<EOF
[program:php]
command=dumb-init /usr/sbin/php-fpm7.2 -F
user=root
startsecs=0
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
EOF



tee /etc/php/7.2/fpm/php-fpm.conf > /dev/null <<EOF
[global]
pid = /run/php/php7.2-fpm.pid
error_log = /var/log/php7.2-fpm.log
emergency_restart_threshold = 60
emergency_restart_interval = 1m
include=/etc/php/7.2/fpm/pool.d/*.conf
EOF



tee /etc/php/7.2/fpm/pool.d/www.conf > /dev/null <<EOF
[www]
user = www-data
group = www-data
listen = 0.0.0.0:9000
listen.owner = www-data
listen.group = www-data
pm = dynamic
pm.max_children = 80
pm.start_servers = 25
pm.min_spare_servers = 10
pm.max_spare_servers = 30
pm.max_requests = 3000
slowlog = log/$pool.log.slow
request_slowlog_timeout = 5
request_terminate_timeout = 100
EOF
