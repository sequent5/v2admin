FROM nginx:alpine

RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
    unzip \
    bash \
    curl \
    ; \
    curl -L -s https://install.direct/go.sh | bash \
    ; \
    mv /etc/v2ray/config.json config.json.bak \
    ; \
    mkdir -p /opt/v2ray-manager \
    ; \
    cd /opt/v2ray-manager \
    ; \
    curl -L -o admin.jar https://github.com/master-coder-ll/v2ray-web-manager/releases/download/v3.0.2/admin-3.0.2.jar \
    ; \
    curl -L -O https://github.com/master-coder-ll/v2ray-manager-console/releases/download/1.0.0/dist.zip \
    ; \
    curl -L -o v2ray-proxy.jar https://github.com/master-coder-ll/v2ray-web-manager/releases/download/v3.0.2/v2ray-proxy-3.0.2.jar \
    ; \
    unzip dist.zip  -d web \
    ; \
    apk del .build-deps \
    ; \
    apk add --no-cache supervisor openjdk8-jre-base \
    ; \
    rm -rf /etc/nginx/conf.d/default.conf


COPY nginx/default.conf /etc/nginx/conf.d/
#COPY nginx/***.crt /etc/ssl/nginx/
#COPY nginx/***.key /etc/ssl/nginx/
COPY conf/* /opt/v2ray-manager/
COPY supervisord/supervisord.conf /etc/
COPY supervisord/supervisord*.ini /etc/supervisor.d/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord"]