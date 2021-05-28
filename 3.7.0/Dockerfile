FROM zookeeper:3.7.0

MAINTAINER linjiancheng (sys.linjc@gmail.com)

ENV ZOO_DATA_ROOT_PATH=/zookeeper \
	ZOO_SERVERS="" \
	ZOO_DESICOVERY="zoo-cluster-discovery" \
	ZOO_NAMESPACE="7723box" \
	ZOO_NODE_COUNT=2

RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        procps \
        net-tools \
        inetutils-ping \
        dnsutils \
        vim; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir -p /opt/docker; \
    mkdir -p /zookeeper;


COPY conf/ /opt/docker/

ENTRYPOINT ["/bin/bash", "/opt/docker/bin/entrypoint.sh"]

