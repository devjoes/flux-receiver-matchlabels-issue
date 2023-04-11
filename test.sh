#!/bin/bash
set -eo pipefail

kubectl config use-context kind-kind
TOKEN=$(head -c 12 /dev/urandom | shasum | cut -d ' ' -f1)
kubectl create secret generic webhook-token --from-literal=token="$TOKEN" -n flux-system
kubectl apply -f flux-resources.yaml --wait
sleep 5
kubectl get Receiver -n flux-system test-receiver -o yaml 
echo "Go create a webhook with token $TOKEN"
#TODO: maybe output the URL and secret
while date; do
	kubectl get configmap test -o yaml | grep foo
	sleep 10s
done
