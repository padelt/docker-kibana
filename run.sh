#!/bin/sh
docker run -d -p 10000:10000 -p 80 -p 9200:9200 -v /docker-volumes/kibana/elasticsearch-logs:/elasticsearch/logs -v /docker-volumes/kibana/logstash:/logstash -v /docker-volumes/kibana/elasticsearch-data:/elasticsearch/data --name kibana kibana
