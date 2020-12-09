FROM adoptopenjdk/openjdk8-openj9:x86_64-alpine-jre8u282-b04_openj9-0.24.0-m1-nightly

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
