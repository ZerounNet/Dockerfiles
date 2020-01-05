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
command=dumb-init code-server --host=0.0.0.0 --port=8887 --auth=none
user=coder
startsecs=0
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
EOF
