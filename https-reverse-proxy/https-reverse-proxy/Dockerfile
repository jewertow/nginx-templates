FROM nginx

RUN cat /etc/resolv.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-selfsigned.key /etc/ssl/private/
COPY nginx-selfsigned.crt /etc/ssl/certs/

RUN nginx -t

