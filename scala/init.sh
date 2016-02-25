#!/bin/bash

pushd /root > /dev/null

if [ -d "scala" ]; then
  echo "Scala seems to be installed. Exiting."
  return 0
fi

SCALA_VERSION="2.11.7"

if [[ "0.7.3 0.8.0 0.8.1" =~ $SPARK_VERSION ]]; then
  SCALA_VERSION="2.9.3"
fi

echo "Unpacking Scala"
if [ "2.11.7" == $SCALA_VERSION  ]; then
  wget http://downloads.lightbend.com/scala/2.11.7/scala-2.11.7.tgz
else  
  wget http://s3.amazonaws.com/spark-related-packages/scala-$SCALA_VERSION.tgz
fi  
tar xvzf scala-*.tgz > /tmp/spark-ec2_scala.log
rm scala-*.tgz
mv `ls -d scala-* | grep -v ec2` scala

popd > /dev/null
