#!/usr/bin/env bash
echo "ZOO_MY_ID=${ZOO_MY_ID}"

bash /docker-entrypoint.sh

bash zkServer.sh start-foreground 

