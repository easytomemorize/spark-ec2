#!/bin/bash

pushd /root > /dev/null
JAVA_VERSION=`java -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3}'`
if [[ $JAVA_VERSION == 1.8* ]]; then
  echo "Java 8 seems to be installed. Exiting."
  return
fi

wget https://s3-us-west-2.amazonaws.com/rm-spark-ec2/jdk-8u73-linux-x64.tar.gz
echo "Unpacking Java 8"
tar xvzf jdk-8*.tar.gz
rm jdk-8*.tar.gz
mv `ls -d jdk1.8* | grep -v ec2` jdk1.8

popd > /dev/null
