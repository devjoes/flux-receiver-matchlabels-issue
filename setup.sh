#!/bin/bash
set -eo pipefail

kind create cluster --image "kindest/node:v1.24.12" # we are on 1.24.10
kubectl config use-context kind-kind
kubectl create ns flux-system
kubectl apply -f flux.yaml --wait
echo 'Waiting'
sleep 90s
kubectl port-forward --namespace flux-system service/notification-controller 9090:80 &
#echo $! > pids
ngrok http 9090
#echo $! >> pids
