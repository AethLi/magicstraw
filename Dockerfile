FROM alpine:3.5
RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://ws.magicstraw.tk/prometheus/v2ray-linux-64.zip \
 && mkdir /usr/bin/v2ray \
#  && mkdir /etc/v2ray \
#  && curl -L -H "Cache-Control: no-cache" -o /etc/v2ray/config.json https://ws.magicstraw.tk/prometheus/config.json \
 && unzip /v2ray.zip -d /usr/bin/v2ray \
 && rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys* \
 && cd /usr/bin/v2ray \
 && chmod u+x v2ray
ENTRYPOINT  [ "/usr/bin/v2ray/v2ray","-config=https://ws.magicstraw.tk/prometheus/config.json" ]
EXPOSE 443