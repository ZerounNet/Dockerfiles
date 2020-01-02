mkdir ~/.config/matplotlib/ -p
cat > ~/.config/matplotlib/matplotlibrc <<EOF
font.family         : WenQuanYi Micro Hei, sans-serif 
font.sans-serif     : WenQuanYi Micro Hei, DejaVu Sans, Bitstream Vera Sans, Computer Modern Sans Serif, Lucida Grande, Verdana, Geneva, Lucid, Arial, Helvetica, Avant Garde, sans-serif
axes.unicode_minus  : False
EOF

cat > ~/entrypoint.sh <<EOF
sudo cp -f /etc/supervisor/supervisord.conf.bak /etc/supervisor/supervisord.conf
echo "environment=TZ='\$TZ',LANG='\$LANG',PASSWORD='\$PASSWORD',MONGODB='\$MONGODB',QARUN='\$QARUN',QAPUBSUB_IP='\$QAPUBSUB_IP',QAPUBSUB_PORT='\$QAPUBSUB_PORT',QAPUBSUB_USER='\$QAPUBSUB_USER',QAPUBSUB_PWD='\$QAPUBSUB_PWD'" | sudo tee -a /etc/supervisor/supervisord.conf
sudo pip install -U quantaxis qastrategy qifiaccount tqsdk tushare pytdx
sudo dumb-init supervisord -n -c /etc/supervisor/supervisord.conf
EOF
chmod a+x ~/entrypoint.sh

mkdir ~/.quantaxis/setting -p
cat > ~/.quantaxis/setting/config.ini <<EOF
[LOG]
path = /home/coder/.quantaxis/log
EOF

mkdir ~/.jupyter/
cat > ~/.jupyter/jupyter_notebook_config.py <<EOF
import os
from IPython.lib import passwd
c.NotebookApp.ip = '127.0.0.1'
c.NotebookApp.port = 8889
c.NotebookApp.notebook_dir = '/home/coder/project'
c.NotebookApp.open_browser = False
c.MultiKernelManager.default_kernel_name = 'python3'
c.NotebookApp.token = ''
#c.NotebookApp.password = passwd(os.environ.get("PASSWORD", 'quanter'))
c.NotebookApp.allow_credentials = True
c.NotebookApp.allow_origin = '*'
c.NotebookApp.allow_remote_access = True
c.NotebookApp.tornado_settings = { 'headers': { 'Content-Security-Policy': "" }}
EOF


sudo tee /etc/supervisor/supervisord.conf.bak > /dev/null <<EOF
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


sudo tee /etc/supervisor/conf.d/nginx.conf > /dev/null <<EOF
[program:nginx]
command = dumb-init nginx -g 'daemon off;'
startsecs=0
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
EOF

sudo tee /etc/supervisor/conf.d/jupyter.conf > /dev/null <<EOF
[program:jupyter]
#environment=PATH="/usr/local/conda/bin:/usr/local/conda/condabin:%(ENV_PATH)s"
command=dumb-init /usr/local/conda/bin/jupyter lab
user=coder
startsecs=0
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
EOF

sudo tee /etc/nginx/passwd > /dev/null   <<EOF
quanter:\$apr1\$YR4SFl7a\$y0gG2hMKlu5P7yB6WayCD/
EOF

sudo tee /etc/nginx/sites-available/default > /dev/null   <<EOF
server {
        listen 80 default_server;
        root /var/www/html;
        auth_basic "who are you";
        auth_basic_user_file /etc/nginx/passwd;
        index index.html index.htm;
        server_name _;
}
EOF
sudo tee /etc/nginx/sites-available/jupyter > /dev/null   <<EOF
server {
        listen 8888;
        auth_basic "who are you";
        auth_basic_user_file /etc/nginx/passwd;
        location / {
            proxy_set_header Host \$host;
            proxy_set_header X-Real-Scheme \$scheme;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_pass  http://127.0.0.1:8889;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_read_timeout 120s;
            proxy_next_upstream error;
        }
}
EOF
sudo ln -s /etc/nginx/sites-available/jupyter /etc/nginx/sites-enabled
