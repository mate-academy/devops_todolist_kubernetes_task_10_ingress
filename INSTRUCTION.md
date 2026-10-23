kubectl get pods -n ingress-nginx

kubectl rollout status deployment/ingress-nginx-controller -n ingress-nginx

kubectl get deployment -n todoapp
kubectl get pods -n todoapp
kubectl get svc -n todoapp

Validate Ingress

kubectl get ingress -n todoapp

Validate HTTP Access

Open in browser:

http://localhost

Troubleshooting

Check the Ingress Controller logs:

kubectl logs -n ingress-nginx deployment/ingress-nginx-controller --tail=100

Check Django logs:

kubectl logs -n todoapp deployment/todoapp --tail=100

Check Service endpoints:

kubectl get endpointslices -n todoapp -l kubernetes.io/service-name=todoapp

Check the current Ingress configuration:

kubectl describe ingress todoapp-ingress -n todoapp
