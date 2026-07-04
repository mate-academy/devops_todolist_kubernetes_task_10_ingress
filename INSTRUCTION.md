1 install Python 3.8 and higher, due to Django 4
2 install kind
3 install kubectl

4 kind create cluster --config cluster.yml
5 run ./bootstrap.sh
6 kubectl apply -f .infrastructure/ingress/ingress.yml

7 kubectl get ns
check ingress-nginx

8 kubectl get pods
check pods: ingress-inginx

9 kubectl get svc
check todoapp-service and port 80

10 The reviewer must open in the browser:
http://localhost/
use dev tools to inspect the network tab, and confirm that the ToDo app UI loads and that there are no 404 status codes