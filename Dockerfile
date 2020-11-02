FROM openjdk:8-jre-slim

USER root

ENV admin_VERSION 3.1.8
ENV web_VERSION 1.1.2

RUN  set -x && \
     echo "Asia/Shanghai" > /etc/timezone && \
     apt-get update && \
     apt-get install -y nginx curl && \
     mkdir -p /opt/jar/db && \
     cd /opt/jar && \
     curl -L -o admin.jar https://glare.now.sh/master-coder-ll/v2ray-web-manager/admin && \
     curl -L -o dist.zip https://glare.now.sh/master-coder-ll/v2ray-manager-console/dist && \
     apt-get remove -y curl && \
     unzip dist.zip  -d web && \
     rm -rf dist.zip && \
     rm -rf /etc/nginx/conf.d/default.conf && \    
     mkdir -p /opt/jar/config 

COPY nginx/default.conf /etc/nginx/conf.d/
ADD config /opt/jar/config
ADD  ./init.sh /opt/jar/run.sh

RUN cd /opt/jar/ && \ 
  chmod +x /opt/jar/admin.jar && \
  chmod +x /opt/jar/run.sh

EXPOSE 80
EXPOSE 443

WORKDIR /opt/jar/
CMD ["/bin/sh", "run.sh"]
