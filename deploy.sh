#!/bin/bash
deployment_name=nginx-deployment
account_name=nginx-admin
secret_name=api-key-secret
pdb_name=nginx-pdb

docker build -t demo/nginx .

# uncomment for local use on a minikube cluster
eval $(minikube docker-env)

kubectl delete deployments,svc "$deployment_name"
kubectl delete serviceaccounts "$account_name"
kubectl delete secrets "$secret_name"
kubectl delete pdb "$pdb_name"
kubectl apply -f manifests/
kubectl autoscale deployment "$deployment_name" --cpu-percent=50 --min=2 --max=10
