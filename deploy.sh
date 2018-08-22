#!/usr/bin/env bash

#Variables

KUBE=`which microk8s.kubectl`
#KUBE='kubectl'
#MYSQL_PASSWORD="test"

${KUBE} apply -f redis/deployment.yml
${KUBE} apply -f redis/service.yml

#Create secrets of they don't exist.

if ! ${KUBE} get secrets | grep mysql-secret > /dev/null ; then
    ${KUBE} create secret generic mysql-secret --from-literal=password=${MYSQL_PASSWORD}
fi

${KUBE} apply -f mysql/volume.yml
${KUBE} apply -f mysql/deployment.yml
${KUBE} apply -f mysql/service.yml


