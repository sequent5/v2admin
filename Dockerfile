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
    mkdir -p /opt/v2ray-manager \
    ; \
    mkdir -p /opt/v2ray-manager/config \
    ; \
    cd /opt/v2ray-manager \
    ; \
    curl -L -o admin.jar https://glare.now.sh/master-coder-ll/v2ray-web-manager/admin \
    ; \
    curl -L -O https://glare.now.sh/master-coder-ll/v2ray-manager-console/dist \
    ; \
    curl -L -o v2ray-proxy.jar https://glare.now.sh/master-coder-ll/v2ray-web-manager/v2ray-proxy \
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
COPY config/* /opt/v2ray-manager/config/
COPY supervisord/supervisord.conf /etc/
COPY supervisord/supervisord*.ini /etc/supervisor.d/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord"]