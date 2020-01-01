cat > ~/.local/share/code-server/coder.json <<EOF
{"lastVisited":{"path":"/home/coder/project","workspace":false}}
EOF


cat > ~/entrypoint.sh <<EOF
PATH="/usr/local/conda/bin:\$PATH"
sudo pip install -U quantaxis qastrategy qifiaccount tqsdk tushare pytdx
dumb-init code-server --host 0.0.0.0 --port 8888
EOF


