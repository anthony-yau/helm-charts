# 选择基础镜像
FROM openjdk:8u342-jdk

# 设置环境变量
ENV JAVA_HOME="/usr/local/openjdk-8/" \
    PATH="/opt/apache-doris/be/bin:$PATH"

# 下载软件至镜像内，可根据需要替换
ADD ./resource/apache-doris-be-1.2.4.1-bin-x86_64 /opt/apache-doris/be
ADD ./resource/apache-doris-dependencies-1.2.4.1-bin-x86_64/java-udf-jar-with-dependencies.jar /opt/apache-doris/be/lib/

RUN apt-get update && \
    apt-get install -y default-mysql-client && \
    apt-get clean

ADD ./resource/init_be.sh /opt/apache-doris/be/bin/
RUN chmod 755 /opt/apache-doris/be/bin/init_be.sh

ENTRYPOINT ["/opt/apache-doris/be/bin/init_be.sh"]