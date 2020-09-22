FROM ghcr.io/m1ngyuan/jdk-11-alpine:1.0.0
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
ENV LANG="en_US.UTF-8"
ENV TERM=xterm
#下载部署 SAE 演示 JAR 包
RUN mkdir -p /home/admin/app/ && wget http://edas-qd.oss-cn-qingdao.aliyuncs.com/docker/xingsong_cluster/jdk11/nacos-service-provider-0.0.1-SNAPSHOT.jar -O /home/admin/app/nacos-service-provider-0.0.1-SNAPSHOT.jar

# 将启动命令写入启动脚本 start.sh
RUN echo 'eval exec java  $CATALINA_OPTS  -jar "/home/admin/app/nacos-service-provider-0.0.1-SNAPSHOT.jar" '> /home/admin/start.sh && chmod +x /home/admin/start.sh
WORKDIR $ADMIN_HOME
CMD ["/bin/sh", "/home/admin/start.sh"]