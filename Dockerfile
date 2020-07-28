FROM alpine:3.5
RUN apk add --no-cache --virtual .build-deps ca-certificates curl nginx \
 && mkdir /run/nginx \
 && touch /run/nginx/nginx.pid \
 && rm /etc/nginx/nginx.conf
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /web/
 RUN nginx -c /etc/nginx/nginx.conf \
 && curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2fly/v2ray-core/releases/download/v4.26.0/v2ray-linux-64.zip \
 && mkdir /usr/bin/v2ray \
 && unzip /v2ray.zip -d /usr/bin/v2ray \
 && rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys* \
 && cd /usr/bin/v2ray \
 && chmod u+x v2ray
CMD [ "nginx -s reload" ]
ENTRYPOINT  [ "/usr/bin/v2ray/v2ray","-config=https://ws.magicstraw.tk/prometheus/config.json" ]
EXPOSE 443