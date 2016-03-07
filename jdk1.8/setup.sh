#!/bin/bash

/root/spark-ec2/copy-dir /root/jdk1.8

for node in $SLAVES $OTHER_MASTERS; do
  ssh -t $SSH_OPTS root@$node "export JAVA_HOME=/root/jdk1.8 && alternatives --install /usr/bin/java java /root/jdk1.8/bin/java 3 && alternatives --config java <<< '3'"
done
