cat > ~/.local/share/code-server/coder.json <<EOF
{"lastVisited":{"path":"/home/coder/project","workspace":false}}
EOF

mkdir ~/project/.vscode -p
cat > ~/project/.vscode/settings.json <<EOF
{
    "python.pythonPath": "/usr/local/bin/python"
}
EOF

sudo tee /etc/supervisor/conf.d/code.conf > /dev/null <<EOF
[program:code]
#environment=PATH="/usr/local/conda/bin:/usr/local/conda/condabin:%(ENV_PATH)s"
command=dumb-init code-server --host=127.0.0.1 --port=3001 --auth=none
user=coder
startsecs=0
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
EOF

sudo tee /etc/nginx/sites-available/code > /dev/null   <<EOF
server {
        listen 3000;
        auth_basic "who are you";
        auth_basic_user_file /etc/nginx/passwd;
        location / {
            proxy_set_header Host \$host;
            proxy_set_header X-Real-Scheme \$scheme;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_pass  http://127.0.0.1:3001;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_read_timeout 120s;
            proxy_next_upstream error;
        }
}
EOF
sudo ln -s /etc/nginx/sites-available/code /etc/nginx/sites-enabled
