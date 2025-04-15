# Testing ingress in Djanjo ToDo list
Checking creation of ingress-nginx namespace
```bash
kubectl get ns ingress-nginx 
```
Run this command to validate that todoapp-ingress is running on right host and port
```bash
kubectl get ingress -n todoapp
```
Follow the link to ensure that website is working as expected:
```
http://localhost
```