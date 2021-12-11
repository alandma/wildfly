#!/bin/bash

# build app-pt001
mvn -B -f ${PWD}/app001/pom.xml install -s /usr/share/maven/ref/settings-docker.xml dependency:resolve -DskipTests 

mvn -B -f ${PWD}/app001/pom.xml package -s /usr/share/maven/ref/settings-docker.xml -DskipTests 

# build app-pt002
mvn -B -f ${PWD}/app002/pom.xml install -s /usr/share/maven/ref/settings-docker.xml dependency:resolve -DskipTests

# build app-pt003
mvn -B -f ${PWD}/app003/pom.xml package -s /usr/share/maven/ref/settings-docker.xml -DskipTests 

# build app-pt004
mvn -B -f ${PWD}/app004/pom.xml package -s /usr/share/maven/ref/settings-docker.xml -DskipTests 
