kind create cluster --config ./cluster.yml

kubectl get nodes

chmod +x ./bootstrap.sh

./bootstrap.sh

cd devops_todolist_kubernetes_task_10_ingress/.infrastructure/ingress

kubectl apply -f ingress.yml

kubectl get ingress -n todoapp

then use IP in browser
http://<IP>/