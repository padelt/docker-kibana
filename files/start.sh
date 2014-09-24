#!/bin/bash
if [ ! -f /logstash/logstash.conf ]
then
  cd /logstash
  tar xz --strip-components=1 -f /logstash-1.4.1.tar.gz 
  cp /root/logstash.conf.sample logstash.conf
fi

supervisord -n -c /etc/supervisord.conf -e debug
