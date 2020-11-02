FROM nginx:alpine

ENV admin_VERSION 3.1.8
ENV web_VERSION 1.1.2

RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
    unzip \
    bash \
    curl && \
    mkdir -p /opt/jar/db && \
    cd /opt/jar && \
    curl -L -o admin.jar https://glare.now.sh/master-coder-ll/v2ray-web-manager/admin && \
    curl -L -o dist.zip https://glare.now.sh/master-coder-ll/v2ray-manager-console/dist && \
    unzip dist.zip  -d web && \
    rm -rf dist.zip && \
    apk del .build-deps && \
    apk add --no-cache bash supervisor openjdk8-jre && \
    rm -rf /etc/nginx/conf.d/default.conf && \
    mkdir -p /opt/jar/config && \
    mkdir -p /opt/supervisor.d && \
    mkdir -p /etc/supervisor.d

COPY nginx/default.conf /etc/nginx/conf.d/
#COPY nginx/***.crt /etc/ssl/nginx/
#COPY nginx/***.key /etc/ssl/nginx/
ADD config /opt/jar/config
COPY supervisord/supervisord.conf /etc/
COPY supervisord/supervisord*.ini /opt/supervisor.d/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 80
EXPOSE 443


ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord"]
