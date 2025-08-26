FROM alpine:latest
RUN apk add --no-cache nginx && mkdir -p /opt/www /run/nginx
COPY index.html /opt/www/index.html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
