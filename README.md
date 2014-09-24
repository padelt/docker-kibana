docker-kibana
=============

Run Kibana, ElasticSearch, Logstash, and Apache2 in Docker.

You need to provide space for ElasticSearch logs & data and for Logstash.
See `run.sh` for an example.
On initial start, the logstash volume will be filled with the Logstash distribution (see `files/start-sh`).
After that, it is up to you to configure it.

