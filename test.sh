#!/bin/bash
set -eo pipefail

kubectl config use-context kind-kind
read -p 'Webhook token: ' token
kubectl create secret generic webhook-token --from-literal=token="$token" -n flux-system
kubectl apply -f flux-resources.yaml