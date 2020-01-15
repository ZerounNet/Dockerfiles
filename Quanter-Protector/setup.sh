cat > /entrypoint.sh <<EOF
htpasswd -nb quanter \${PASSWORD:-"quanter"} > /etc/nginx/passwd
dumb-init nginx -g 'daemon off;'
EOF
chmod a+x /entrypoint.sh

tee /etc/nginx/sites-available/qarun > /dev/null   <<EOF
server {
        listen 8010;
        location / {
            proxy_set_header Host \$host;
            proxy_set_header X-Real-Scheme \$scheme;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_pass  http://qarun:8010;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_read_timeout 120s;
            proxy_next_upstream error;
        }
}
EOF
ln -s /etc/nginx/sites-available/qarun /etc/nginx/sites-enabled

tee /etc/nginx/sites-available/qamarketcollector > /dev/null   <<EOF
server {
        listen 8011;
        location / {
            proxy_set_header Host \$host;
            proxy_set_header X-Real-Scheme \$scheme;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_pass  http://qamarketcollector:8011;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_read_timeout 120s;
            proxy_next_upstream error;
        }
}
EOF
ln -s /etc/nginx/sites-available/qamarketcollector /etc/nginx/sites-enabled

tee /etc/nginx/sites-available/qatrader > /dev/null   <<EOF
server {
        listen 8020;
        location / {
            proxy_set_header Host \$host;
            proxy_set_header X-Real-Scheme \$scheme;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_pass  http://qatrader:8020;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_read_timeout 120s;
            proxy_next_upstream error;
        }
}
EOF
ln -s /etc/nginx/sites-available/qatrader /etc/nginx/sites-enabled

tee /etc/nginx/sites-available/code > /dev/null   <<EOF
server {
        listen 8887;
        auth_basic "who are you";
        auth_basic_user_file /etc/nginx/passwd;
        location / {
            proxy_set_header Host \$host;
            proxy_set_header X-Real-Scheme \$scheme;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_pass  http://qacommunity:8887;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_read_timeout 120s;
            proxy_next_upstream error;
        }
}
EOF
ln -s /etc/nginx/sites-available/code /etc/nginx/sites-enabled

tee /etc/nginx/sites-available/jupyter > /dev/null   <<EOF
server {
        listen 8888;
        auth_basic "who are you";
        auth_basic_user_file /etc/nginx/passwd;
        location / {
            proxy_set_header Host \$host;
            proxy_set_header X-Real-Scheme \$scheme;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_pass  http://qacommunity:8888;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_read_timeout 120s;
            proxy_next_upstream error;
        }
}
EOF
ln -s /etc/nginx/sites-available/jupyter /etc/nginx/sites-enabled

tee /etc/nginx/sites-available/puppet > /dev/null   <<EOF
server {
        listen 8889;
        auth_basic "who are you";
        auth_basic_user_file /etc/nginx/passwd;
        location / {
            proxy_set_header Host \$host;
            proxy_set_header X-Real-Scheme \$scheme;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_pass  http://puppet:8889;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_read_timeout 120s;
            proxy_next_upstream error;
        }
}
EOF
ln -s /etc/nginx/sites-available/puppet /etc/nginx/sites-enabled

tee /etc/nginx/sites-available/default > /dev/null   <<EOF
server {
        listen 9000 default_server;
        root /var/www/html;
        auth_basic "who are you";
        auth_basic_user_file /etc/nginx/passwd;
        index index.html index.htm;
        server_name _;
}
EOF
