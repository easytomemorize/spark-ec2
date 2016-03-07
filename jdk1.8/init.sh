#!/bin/bash

pushd /root > /dev/null
JAVA_VERSION=`java -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3}'``'") }'`
if [[ $JAVA_VERSION == 1.8*  ]]; then
  echo "Java 8 seems to be installed. Exiting."
  return
fi

wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.tar.gz"
echo "Unpacking Java 8"
tar xvzf jdk-8*.tgz > /tmp/spark-ec2_jdk1.8.log
rm jdk-8*.tgz
mv `ls -d jdk1.8* | grep -v ec2` jdk1.8

popd > /dev/null
