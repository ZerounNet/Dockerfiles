cat > /entrypoint.sh <<EOF
dumb-init nginx -g 'daemon off;'
EOF
chmod a+x /entrypoint.sh

tee /etc/nginx/passwd > /dev/null   <<EOF
quanter:\$apr1\$YR4SFl7a\$y0gG2hMKlu5P7yB6WayCD/
EOF

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
