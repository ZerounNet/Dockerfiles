mkdir ~/.config/matplotlib/ -p
cat > ~/.config/matplotlib/matplotlibrc <<EOF
font.family         : WenQuanYi Micro Hei, sans-serif 
font.sans-serif     : WenQuanYi Micro Hei, DejaVu Sans, Bitstream Vera Sans, Computer Modern Sans Serif, Lucida Grande, Verdana, Geneva, Lucid, Arial, Helvetica, Avant Garde, sans-serif
axes.unicode_minus  : False
EOF

cat > ~/entrypoint.sh <<EOF
PATH="/usr/local/conda/bin:\$PATH"
sudo pip install -U quantaxis qastrategy qifiaccount tqsdk tushare pytdx
sudo dumb-init supervisord -n
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
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.port = int(os.getenv('PORT', 8888))
c.NotebookApp.notebook_dir = '/home/coder/project'
c.NotebookApp.open_browser = False
c.MultiKernelManager.default_kernel_name = 'python3'
c.NotebookApp.token = ''
c.NotebookApp.password = passwd(os.environ.get("PASSWORD", 'quantaxis'))
c.NotebookApp.allow_credentials = True
c.NotebookApp.allow_origin = '*'
c.NotebookApp.allow_remote_access = True
c.NotebookApp.tornado_settings = { 'headers': { 'Content-Security-Policy': "" }}
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
environment=PATH="/usr/local/conda/bin:\$PATH"
command=dumb-init jupyter lab
user=coder
startsecs=0
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
EOF

