#!/usr/bin/env bash

set -eux;
#获取ZOO_MY_ID
HOST_ID=${HOSTNAME##*[-]}
isnum=`isNum $HOST_ID`
if [[ $isnum == 1 ]]; then
	ZOO_MY_ID=`expr $HOST_ID "+" 1`
	export ZOO_MY_ID
fi
#配置ZOO_DATA_DIR
ZOO_DATA_DIR=${ZOO_DATA_ROOT_PATH}/${HOSTNAME}/data
export ZOO_DATA_DIR
if [[ ! -d ${ZOO_DATA_DIR} ]]; then
	mkdir -p ${ZOO_DATA_DIR}
fi
#配置ZOO_DATA_LOG_DIR
ZOO_DATA_LOG_DIR=${ZOO_DATA_ROOT_PATH}/${HOSTNAME}/datalog
export ZOO_DATA_LOG_DIR
if [[ ! -d ${ZOO_DATA_LOG_DIR} ]]; then
	mkdir -p ${ZOO_DATA_LOG_DIR}
fi
if [[ -z $ZOO_SERVERS ]]; then
    ZOO_SERVERS="server.1=${HOSTNAME}:2888:3888;2181"
else
	c_zoo=0
	while [[ ${c_zoo} < ${ZOO_NODE_COUNT} ]]; do
		hs_svc="$ZOO_DESICOVERY.$ZOO_NAMESPACE.svc.cluster.local."
		c_zoo=`dig $hs_svc |grep ^"$hs_svc" |wc -l`
		echo "当前c_zoo=$c_zoo"
		sleep 15
	done
	zoo_list=`dig $hs_svc |grep ^"$hs_svc" |awk -F " " '{print $5}'|sort`
	local_ip=`cat /etc/hosts |grep $HOSTNAME |awk -F " " '{print $1}'`
	i=1
	ZOO_SERVERS=""
	for line in $zoo_list; do
		zoo_server=`nslookup $line |grep name |awk -F " " '{print $4}' |awk 'END{print}'`
		if [[ -n $zoo_server ]]; then
			if [[ $line == $local_ip ]]; then
				zoo_server="0.0.0.0"
			fi
			z_s="server.$i=${zoo_server}:2888:3888;2181 "
			ZOO_SERVERS=$ZOO_SERVERS$z_s
			i=`expr $i + 1`
		fi
	done

fi
echo "当前ZOO_SERVERS="$ZOO_SERVERS;

echo "${ZOO_MY_ID:-1}" > "$ZOO_DATA_DIR/myid"


