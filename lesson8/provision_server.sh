#!/bin/bash

# Установка Apache и нужных модулей
apt update
apt install -y apache2 openssl

a2enmod ssl
a2enmod rewrite

# Создание SSL сертификата
mkdir -p /etc/apache2/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/apache2/ssl/mysite.key \
  -out /etc/apache2/ssl/mysite.crt \
  -subj "/C=RU/ST=Moscow/L=Moscow/O=DevOps/CN=mysite.local"

# Создание сайта
cat <<EOF > /etc/apache2/sites-available/mysite.conf
<VirtualHost *:80>
    ServerName mysite.local
    ServerAlias www.mysite.local
    Redirect permanent / https://mysite.local/
</VirtualHost>

<VirtualHost *:443>
    ServerName mysite.local
    DocumentRoot /var/www/html
    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/mysite.crt
    SSLCertificateKeyFile /etc/apache2/ssl/mysite.key

    RewriteEngine On
    RewriteCond %{HTTP_HOST} ^www\. [NC]
    RewriteRule ^(.*)$ https://mysite.local\$1 [L,R=301]
</VirtualHost>
EOF

# Включаем сайт
a2ensite mysite
systemctl restart apache2
cp /etc/apache2/ssl/mysite.crt /vagrant/mysite.crt
