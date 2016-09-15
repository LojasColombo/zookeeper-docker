What is Apache Zookeeper?
---

ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. All of these kinds of services are used in some form or another by distributed applications. Each time they are implemented there is a lot of work that goes into fixing the bugs and race conditions that are inevitable. Because of the difficulty of implementing these kinds of services, applications initially usually skimp on them ,which make them brittle in the presence of change and difficult to manage. Even when done correctly, different implementations of these services lead to management complexity when the applications are deployed.

How to use this image
---

**Standalone**

```bash
docker run --name standalone-zookeeper --restart always -d lojascolombo/zookeeper:latest
```

**Replicated mode**

```bash
docker network create --driver bridge zookeeper-network

docker run --name=zookeeper1 --restart=always --network=zookeeper-network -d -e ZOOKEEPER_MYID="1" -e ZOOKEEPER_SERVERS="server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888" lojascolombo/zookeeper:latest

docker run --name=zookeeper2 --restart=always --network=zookeeper-network -d -e ZOOKEEPER_MYID="2" -e ZOOKEEPER_SERVERS="server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888" lojascolombo/zookeeper:latest

docker run --name=zookeeper3 --restart=always --network=zookeeper-network -d -e ZOOKEEPER_MYID="3" -e ZOOKEEPER_SERVERS="server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888" lojascolombo/zookeeper:latest
```

Environment variables
---

 * ZOOKEEPER_MYID
 * ZOOKEEPER_SERVERS
 * ZOOKEEPER_TICK_TIME
 * ZOOKEEPER_INIT_LIMIT
 * ZOOKEEPER_SYNC_LIMIT
 * ZOOKEEPER_CLIENT_PORT
 * ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT
 * ZOOKEEPER_AUTOPURGE_PURGE_INTERVALt
