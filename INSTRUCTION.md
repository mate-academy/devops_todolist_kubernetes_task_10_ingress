Clone repository
clone repository
git clone https://github.com/mate-academy/devops_todolist_kubernetes_task_10_ingress.git
go to folder repository
cd ./devops_todolist_kubernetes_task_10_ingres

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
go to page http://localhost in your browser with developer tools (Network/Console) 
there should not be any requests failing with the 404 status code