#!/bin/bash

set -x

if [ ! -d $OPENSHIFT_DATA_DIR/m2/repository ]
then
    mkdir -p $OPENSHIFT_DATA_DIR/m2/repository
fi

if [ ! -d $OPENSHIFT_DATA_DIR/logs ]
then
    mkdir -p $OPENSHIFT_DATA_DIR/logs
fi

if [ ! -d $OPENSHIFT_DATA_DIR/apache-maven-3.3.9 ]
then
    wget -P $OPENSHIFT_DATA_DIR http://mirrors.rackhosting.com/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
    tar xvf $OPENSHIFT_DATA_DIR/apache-maven*.tar.gz --directory $OPENSHIFT_DATA_DIR
    rm -f $OPENSHIFT_DATA_DIR/apache-maven*.tar.gz
fi


export JAVA_HOME=/etc/alternatives/java_sdk_1.8.0
export M2=$OPENSHIFT_DATA_DIR/apache-maven-3.3.9/bin
export MAVEN_OPTS="-Xms384m -Xmx412m"
export PATH=$JAVA_HOME/bin:$PATH

cd $OPENSHIFT_REPO_DIR


$M2/mvn --version
$M2/mvn -s settings.xml clean install