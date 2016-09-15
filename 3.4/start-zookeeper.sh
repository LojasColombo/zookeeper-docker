#!/bin/sh

ChangeConfig () {
  file=$1
  key=$2
  value=$3
  if [ ! -z "$value" ]; then
    if egrep -q "(^|^#)${key}=" $file; then
        sed -r -i "s@(^|^#)(${key})=(.*)@\2=${value}@g" $file
    else
        echo "${key}=${value}" >> $file
    fi
  fi
}

echo "${ZOOKEEPER_MYID:-1}" > /opt/zookeeper/data/myid

cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg

ChangeConfig "/opt/zookeeper/conf/zoo.cfg" "dataDir" "/opt/zookeeper/data"
ChangeConfig "/opt/zookeeper/conf/zoo.cfg" "tickTime" "${ZOOKEEPER_TICK_TIME}"
ChangeConfig "/opt/zookeeper/conf/zoo.cfg" "initLimit" "${ZOOKEEPER_INIT_LIMIT}"
ChangeConfig "/opt/zookeeper/conf/zoo.cfg" "syncLimit" "${ZOOKEEPER_SYNC_LIMIT}"
ChangeConfig "/opt/zookeeper/conf/zoo.cfg" "clientPort" "${ZOOKEEPER_CLIENT_PORT}"
ChangeConfig "/opt/zookeeper/conf/zoo.cfg" "autopurge.snapRetainCount" "${ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT}"
ChangeConfig "/opt/zookeeper/conf/zoo.cfg" "autopurge.purgeInterval" "${ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL}"

for server in $ZOOKEEPER_SERVERS; do
  echo "$server" >> /opt/zookeeper/conf/zoo.cfg.tmp
done

/opt/zookeeper/bin/zkServer.sh start-foreground
