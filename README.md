# k8s-docker-elastic


Elasticsearch Docker image for kubernetes.


## Installs

* [OpenJDK 8u112](http://openjdk.java.net/projects/jdk8u/releases/8u112.html)
* [Elasticsearch 5.3.0](https://www.elastic.co/guide/en/elasticsearch/reference/5.3/release-notes-5.3.0.html)


## Run

### Attention

* In order for `bootstrap.mlockall` to work, `ulimit` must be allowed to run in the container. Run with `--privileged` to enable this.
* [Multicast discovery is no longer built-in](https://www.elastic.co/guide/en/elasticsearch/reference/2.3/breaking_20_removed_features.html#_multicast_discovery_is_now_a_plugin)

Ready to use node for cluster `elasticsearch-default`:
```
docker run --name elasticsearch \
	--detach \
	--privileged \
	--volume /path/to/data_folder:/data \
        k8s-docker-elastic
```

Ready to use node for cluster `elasticsearch`:
```
docker run --name elasticsearch \
	--detach \
	--privileged \
	--volume /path/to/data_folder:/data \
	-e CLUSTER_NAME=elasticsearch \
        k8s-docker-elastic
```

Ready to use node for cluster `elasticsearch`, with 8GB heap allocated to Elasticsearch:
```
docker run --name elasticsearch \
	--detach \
	--privileged \
	--volume /path/to/data_folder:/data \
	-e ES_JAVA_OPTS="-Xms8g -Xmx8g" \
        k8s-docker-elastic
```

**Master-only** node for cluster `elasticsearch`:
```
docker run --name elasticsearch \
	--detach \
	--privileged \
	--volume /path/to/data_folder:/data \
	-e NODE_DATA=false \
	-e HTTP_ENABLE=false \
        k8s-docker-elastic
```

**Data-only** node for cluster `elasticsearch`:
```
docker run --name elasticsearch \
	--detach --volume /path/to/data_folder:/data \
	--privileged \
	-e NODE_MASTER=false \
	-e HTTP_ENABLE=false \
        k8s-docker-elastic
```

**Client-only** node for cluster `elasticsearch`:
```
docker run --name elasticsearch \
	--detach \
	--privileged \
	--volume /path/to/data_folder:/data \
	-e NODE_MASTER=false \
	-e NODE_DATA=false \
        k8s-docker-elastic
```

### Environment variables

This image can be configured by means of environment variables, that one can set on a `Deployment`.

* [CLUSTER_NAME](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-configuration.html#cluster-name)
* [NODE_NAME](https://www.elastic.co/guide/en/elasticsearch/reference/current/important-settings.html#node.name)
* [NODE_MASTER](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html#master-node)
* [NODE_DATA](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html#data-node)
* [NETWORK_HOST](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-network.html#network-interface-values)
* [HTTP_ENABLE](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-http.html#_settings_2)
* [HTTP_CORS_ENABLE](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-http.html#_settings_2)
* [HTTP_CORS_ALLOW_ORIGIN](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-http.html#_settings_2)
* [NUMBER_OF_MASTERS](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-zen.html#master-election)
* [MAX_LOCAL_STORAGE_NODES](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html#max-local-storage-nodes)
* [ES_JAVA_OPTS](https://www.elastic.co/guide/en/elasticsearch/reference/current/heap-size.html)
* [ES_PLUGINS_INSTALL](https://www.elastic.co/guide/en/elasticsearch/plugins/current/installation.html) - comma separated list of Elasticsearch plugins to be installed. Example: `ES_PLUGINS_INSTALL="repository-gcs,x-pack"`. Defaults to `ES_PLUGINS_INSTALL="x-pack"`

#### X Pack Plugin

* [X_PACK_SECURITY_ENABLED](https://www.elastic.co/guide/en/x-pack/current/installing-xpack.html)
* [X_PACK_MONITORING_ENABLED](https://www.elastic.co/guide/en/x-pack/current/installing-xpack.html)
* [X_PACK_GRAPH_ENABLED](https://www.elastic.co/guide/en/x-pack/current/installing-xpack.html)
* [X_PACK_WATCHER_ENABLED](https://www.elastic.co/guide/en/x-pack/current/installing-xpack.html)

