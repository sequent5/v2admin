cp  /opt/jar/config/web.conf /etc/nginx/conf.d/default.conf
nohup java -jar -Xms40m -Xmx40m -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=80m /opt/jar/admin.jar --spring.config.location=/opt/jar/config/admin.yaml &
nginx -g 'daemon off;'
