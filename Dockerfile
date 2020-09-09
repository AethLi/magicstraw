FROM ubuntu:latest
RUN apt update -y \
 && apt install -y curl nginx unzip \
 && rm /etc/nginx/nginx.conf
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /web/
 RUN  curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2fly/v2ray-core/releases/download/v4.26.0/v2ray-linux-64.zip \
 && mkdir /usr/bin/v2ray \
 && unzip /v2ray.zip -d /usr/bin/v2ray \
 && rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys* \
 && cd /usr/bin/v2ray \
 && chmod u+x v2ray \
 && nginx -t
CMD ["nginx" ,"-g", "daemon off;"]
ENTRYPOINT  [ "/usr/bin/v2ray/v2ray","-config=https://ws.magicstraw.tk/prometheus/config.json" ]
EXPOSE 443