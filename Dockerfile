FROM dockerfile/java:oracle-java8
 
# Install Runit
RUN apt-get update
RUN apt-get install -y runit
ADD sv /etc/service
CMD /usr/sbin/runsvdir-start

# Install sshd
RUN apt-get install -y openssh-server && echo 'root:root' | chpasswd

# Install apache
RUN apt-get install -y apache2
RUN service apache2 restart

# ElasticSearch
RUN curl https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz | tar xz && \
    mv elasticsearch-* /elasticsearch

# Kibana
RUN curl https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz | tar xz && \
    mv kibana-* /kibana
RUN sed -i -e 's|elasticsearch:.*|elasticsearch: "http://" + window.location.hostname + ":" + 9200,|' /kibana/config.js
RUN rm -rf /var/www/html/* && mv /kibana/* /var/www/html/

# Logstash
RUN curl https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz | tar xz 
#java -jar logstash-1.2.2-flatjar.jar agent -f docker-kibana/logstash.conf

# 80=kibana, 9200=elasticsearch, 49021=logstash
EXPOSE 80 9200 49021


