FROM quay.io/pires/docker-jre:8u112_1

MAINTAINER rangertaha@gmail.com

# Export HTTP & Transport
EXPOSE 9200 9300

ENV VERSION 5.3.0

# Install Elasticsearch.
RUN apk add --update bash curl ca-certificates sudo util-linux && \
  ( curl -Lskj https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$VERSION.tar.gz | \
  gunzip -c - | tar xf - ) && \
  mv /elasticsearch-$VERSION /elasticsearch && \
  rm -rf $(find /elasticsearch | egrep "(\.(exe|bat)$)") && \
  apk del curl

# Volume for Elasticsearch data
VOLUME ["/data"]

# Copy configuration
COPY config /elasticsearch/config

# Copy run script
COPY run.sh /

# Set environment variables defaults
ENV NAMESPACE default
ENV ES_JAVA_OPTS "-Xms512m -Xmx512m"
ENV CLUSTER_NAME elasticsearch
ENV NODE_MASTER true
ENV NODE_DATA true
ENV NODE_INGEST true
ENV HTTP_ENABLE true
ENV NETWORK_HOST "0.0.0.0"
ENV HTTP_CORS_ENABLE true
ENV HTTP_CORS_ALLOW_ORIGIN *
ENV NUMBER_OF_MASTERS 1
ENV NUMBER_OF_SHARDS 1
ENV NUMBER_OF_REPLICAS 0
ENV MAX_LOCAL_STORAGE_NODES 1
ENV DISCOVERY_SERVICE elasticsearch-discovery
ENV ES_PLUGINS_INSTALL x-pack
ENV X_PACK_SECURITY_ENABLED false
ENV X_PACK_MONITORING_ENABLED false
ENV X_PACK_GRAPH_ENABLED false
ENV X_PACK_WATCHER_ENABLED false

CMD ["/run.sh"]