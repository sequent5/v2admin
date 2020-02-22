#!/bin/sh
java -jar -Xms40m -Xmx40m -XX:MaxDirectMemorySize=10M -XX:MaxMetaspaceSize=80m /opt/v2ray-manager/admin.jar --spring.config.location=/opt/v2ray-manager/config/admin.yaml