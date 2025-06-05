### Ingress check 
kubectl get ingress -n todoapp

### Ingress rules check
kubectl describe ingress todo-ingress -n todoapp

### Open in Browser 
http://localhost:<NodePort>/