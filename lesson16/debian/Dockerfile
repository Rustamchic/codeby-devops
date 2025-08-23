FROM debian:11
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/* && mkdir -p /opt/www /run/nginx
COPY index.html /opt/www/index.html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx","-g","daemon off;"]
