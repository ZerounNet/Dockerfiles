mkdir ~/.config/matplotlib/ -p
cat > ~/.config/matplotlib/matplotlibrc <<EOF
font.family         : WenQuanYi Micro Hei, sans-serif 
font.sans-serif     : WenQuanYi Micro Hei, DejaVu Sans, Bitstream Vera Sans, Computer Modern Sans Serif, Lucida Grande, Verdana, Geneva, Lucid, Arial, Helvetica, Avant Garde, sans-serif
axes.unicode_minus  : False
EOF

cat > ~/entrypoint.sh <<EOF
sudo /usr/local/conda/bin/pip install -U quantaxis qastrategy qifiaccount tqsdk tushare pytdx
dumb-init code-server --host 0.0.0.0 --port 8888
EOF
chmod u+x ~/entrypoint.sh

mkdir ~/.quantaxis/setting -p
cat > ~/.quantaxis/setting/config.ini <<EOF
[MONGODB]
uri = mongodb://mgdb:27017

[LOG]
path = '~/.quantaxis/log'
EOF


