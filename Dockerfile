FROM dockerfile/java:oracle-java8
 
#Runit
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y runit 
CMD /usr/sbin/runsvdir-start

#SSHD
RUN apt-get install -y openssh-server && mkdir -p /var/run/sshd && echo 'root:root' |chpasswd
#RUN sed -i "s/session.*required.*pam_loginuid.so/#session    required     pam_loginuid.so/" /etc/pam.d/sshd
#RUN sed -i "s/PermitRootLogin without-password/#PermitRootLogin without-password/" /etc/ssh/sshd_config

#Utilities
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim less net-tools inetutils-ping curl git telnet nmap socat dnsutils netcat tree htop unzip sudo software-properties-common

# Install apache
RUN apt-get install -y apache2
RUN service apache2 restart

#ElasticSearch
RUN curl https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz | tar xz && \
    mv elasticsearch-* /elasticsearch

#Kibana
RUN curl https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz | tar xz && \
    mv kibana-* /kibana
RUN rm -rf /var/www/html/* && mv /kibana/* /var/www/html/

#Logstash
RUN curl https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz | tar xz 
#java -jar logstash-1.2.2-flatjar.jar agent -f docker-kibana/logstash.conf
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libzmq-dev

#Add runit services
ADD sv /etc/service 

#Configuration
RUN sed -i -e 's|elasticsearch:.*|elasticsearch: "http://" + window.location.hostname + ":" + 9200,|' /kibana/config.js

#80=ngnx, 9200=elasticsearch, 49021=logstash/zeromq
EXPOSE 80 9200 49021


