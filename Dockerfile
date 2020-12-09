FROM openjdk:8-jre-slim

USER root

ENV admin_VERSION 3.1.8
ENV web_VERSION 1.1.2

RUN  set -x && \
     apt-get update && \
     apt-get install -y nginx curl unzip && \
     mkdir -p /opt/jar/db && \
     cd /opt/jar && \
     curl -L -o admin.jar https://glare.now.sh/master-coder-ll/v2ray-web-manager/admin && \
     curl -L -o dist.zip https://glare.now.sh/master-coder-ll/v2ray-manager-console/dist && \     
     unzip dist.zip  -d web && \
     apt-get remove -y curl unzip && \
     rm -rf dist.zip && \
     rm -rf /etc/nginx/sites-enabled/default && \    
     mkdir -p /opt/jar/config 

ADD config/admin.yaml /opt/jar/config
ADD config/web.conf /etc/nginx/conf.d/default.conf
ADD ./init.sh /opt/jar/init.sh

RUN chmod +x /opt/jar/init.sh

EXPOSE 80

WORKDIR /opt/jar/
CMD ["/bin/sh", "init.sh"]
