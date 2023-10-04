#!/bin/bash

task(){
    kubectl logs -f mytestnginx
}

trap ctrl_c INT

function ctrl_c() {
    kubectl delete pod mytestnginx
    exit 0
}

kubectl run mytestnginx --image nginx

while true; do
    ST=$(kubectl get pod mytestnginx --no-headers | awk '{print $3}')
    echo $ST
    if [ "$ST" = "Running" ];then
        break
    fi
done

for i in `seq 1 $@`; do
    task &
done


while true; do
    sleep 1
    echo -n "."
done