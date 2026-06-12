Clone repository
git clone repository
go to folder repository

## PREDEPLOY
if you have claster - delete it
kind delete cluster

create cluster
kind create cluster --config cluster.yml

## DEPLOY
start file bootstrap
sh ./bootstrap.sh

## TESTING
kubectl get pods -n ingress-nginx
kubectl get ingress
kubectl get endpoints todoapp
kubectl get pods -n todoapp
go to page http://localhost in your browser