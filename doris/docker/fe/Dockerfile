# 选择基础镜像
FROM openjdk:8u342-jdk

# 设置环境变量
ENV JAVA_HOME="/usr/local/openjdk-8/" \
    PATH="/opt/apache-doris/fe/bin:$PATH"

# 下载软件至镜像内，可根据需要替换
COPY ./resource/apache-doris-fe-1.2.3-bin-x86_64/ /opt/apache-doris/fe/

RUN apt-get update && \
    apt-get install -y default-mysql-client && \
    apt-get clean

ADD ./resource/init_fe.sh /opt/apache-doris/fe/bin/
RUN chmod 755 /opt/apache-doris/fe/bin/init_fe.sh

ENTRYPOINT ["/opt/apache-doris/fe/bin/init_fe.sh"]
