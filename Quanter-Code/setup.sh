tee ~/.local/share/code-server/coder.json > /dev/null <<EOF
{"lastVisited":{"path":"/home/quanter/project","workspace":false}}
EOF

mkdir ~/project/.vscode -p
tee ~/project/.vscode/settings.json > /dev/null <<EOF
{
    "python.pythonPath": "/project/.vscode/settings.json"
}
EOF

sudo tee /etc/supervisor/conf.d/code.conf > /dev/null <<EOF
[program:code]
command=dumb-init code-server --host=0.0.0.0 --port=8887 --auth=none
user=quanter
startsecs=0
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
EOF
