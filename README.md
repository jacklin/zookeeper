# zookeeper
基于官方zookeeper镜像创建支持k8s部署
###环境变量说明
ZOO_DATA_ROOT_PATH 配置数据存储主目录
ZOO_SERVERS 集群服务器列表如："server.1=zoo-0.zoo-cluster-discovery.7723box.svc.cluster.local.:2888:3888;2181 server.2=zoo-1.zoo-cluster-discovery.7723box.svc.cluster.local.:2888:3888;2181"
ZOO_DESICOVERY k8s服务一般使用实例间服务发现（Headless Service）
ZOO_NAMESPACE k8s命名空间namespace
ZOO_NODE_COUNT zookeeper集群预设多少个节点
###重点：ZOO_SERVERS
init_config.sh内获取ZOO_SERVERS过程
基本原理获取当前群集中多少可以被访问的pod
使用dig service.namespace.svc.cluster.local获取当前pod 的ip
再通过ip反向解析 nslookup ip 获取 对应的ip-name.service.namespace.svc.cluster.local
完成zoo_servers值拼接
另外，启动pod 需要同时启动，如有其中一个节点出问题，重新伸缩为0再次尝试