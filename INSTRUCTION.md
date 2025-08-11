## Prerequisites
- Docker
- kind
- kubectl

## Steps to validate
1. Create the cluster and deploy the app + ingress:
   ```bash
   chmod +x ./bootstrap.sh
   ./bootstrap.sh
   
Verify resources:
kubectl get pods -A
kubectl get svc
kubectl get ingress

Open the app:

Go to http://localhost in your browser.

You should see the ToDo app running.

Validate no 404s in the console:

Open browser DevTools → Console → reload page.

There must not be requests failing with status 404.

(Optional) CLI check:

bash
Копировать
Редактировать
curl -i http://localhost/

Expected: HTTP/1.1 200 OK (or app page content).