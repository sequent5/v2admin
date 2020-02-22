FROM nginx:alpine

ENV WEB_VERSION 3.0.3
ENV CONSOLE_VERSION 1.0.0

RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
    unzip \
    bash \
    curl \
    ; \
    curl -L -s https://install.direct/go.sh | bash \
    ; \
    mv /etc/v2ray/config.json /etc/v2ray/config.json.bak \
    ; \
    mkdir -p /opt/v2ray-manager \
    ; \
    mkdir -p /opt/v2ray-manager/config \
    ; \
    cd /opt/v2ray-manager \
    ; \
    curl -L -o admin.jar https://github.com/master-coder-ll/v2ray-web-manager/releases/download/v${WEB_VERSION}/admin-${WEB_VERSION}.jar \
    ; \
    curl -L -O https://github.com/master-coder-ll/v2ray-manager-console/releases/download/${CONSOLE_VERSION}/dist.zip \
    ; \
    curl -L -o v2ray-proxy.jar https://github.com/master-coder-ll/v2ray-web-manager/releases/download/v${WEB_VERSION}/v2ray-proxy-${WEB_VERSION}.jar \
    ; \
    unzip dist.zip  -d web \
    ; \
    apk del .build-deps \
    ; \
    apk add --no-cache supervisor openjdk8-jre-base \
    ; \
    rm -rf /etc/nginx/conf.d/default.conf \
    ; \
    mkdir -p /opt/jar/db 


COPY nginx/default.conf /etc/nginx/conf.d/
#COPY nginx/***.crt /etc/ssl/nginx/
#COPY nginx/***.key /etc/ssl/nginx/
COPY config/config.json /etc/v2ray/
COPY config/*.properties /opt/v2ray-manager/config
COPY supervisord/supervisord.conf /etc/
COPY supervisord/supervisord*.ini /etc/supervisor.d/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord"]