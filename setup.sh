#!/bin/bash
set -eo pipefail

kind create cluster --image "kindest/node:v1.24.12" # we are on 1.24.10
kubectl config use-context kind-kind
kubectl create ns flux-system
kubectl apply -f flux.yaml --wait
echo 'Waiting'
sleep 90s
tmux split-window -v 'kubectl port-forward --namespace flux-system service/webhook-receiver 9292:80'
tmux split-window -v 'ngrok http 9292'
