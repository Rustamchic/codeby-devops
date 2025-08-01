#!/bin/bash

# Добавляем запись в /etc/hosts
echo "192.168.56.10 mysite.local www.mysite.local" >> /etc/hosts

# Устанавливаем curl и ca-certificates
apt update
apt install -y ca-certificates curl

# Копируем сертификат с сервера (через shared folder, а не SCP)
mkdir -p /usr/local/share/ca-certificates
cp /vagrant/mysite.crt /usr/local/share/ca-certificates/
update-ca-certificates
