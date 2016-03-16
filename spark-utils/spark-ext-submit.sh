#!/bin/bash

JAR_DIR="$HOME/ext-jars"
mkdir -p $JAR_DIR
S3_PATH="https://s3-us-west-2.amazonaws.com/rm-spark-ec2/jars"
JARS=("config-1.3.0.jar" "jackson-annotations-2.7.2.jar" "jackson-core-2.7.2.jar" "jackson-databind-2.7.2.jar" "jackson-module-paranamer-2.7.2.jar" "jackson-module-scala_2.11-2.7.2.jar")
for JAR in "${JARS[@]}"
do
  JAR_PATH="$JAR_DIR/$JAR"
  if [ ! -f $JAR_PATH ]
  then
    wget -O "$JAR_PATH" "$S3_PATH/$JAR"
  fi
done

EXTRA_CLASSPATH=""
for JAR in $JAR_DIR/*.jar
do
  if [ -z $EXTRA_CLASSPATH ]
  then
    EXTRA_CLASSPATH=$JAR
  else
    EXTRA_CLASSPATH=$EXTRA_CLASSPATH":"$JAR
  fi  
done

COPY_CMD=("$HOME/spark-ec2/copy-dir" "$JAR_DIR")
"${COPY_CMD[@]}"

SUBMIT_CMD=("$HOME/spark/bin/spark-submit" "--driver-class-path" "$EXTRA_CLASSPATH" "--conf" "spark.executor.extraClassPath=$EXTRA_CLASSPATH" "$@")

"${SUBMIT_CMD[@]}"