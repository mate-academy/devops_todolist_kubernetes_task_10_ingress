## 1. Cluster and other resources creating

    kind create cluster --config cluster.yml
    kubectl apply -f infrastructure/ingress/namespace.yml
    kubectl apply -f infrastructure/ingress/ingress-pod.yml
    kubectl apply -f infrastructure/ingress/ingress.yml -n todoapp
    ./bootstrap.sh

## 2. Validate Pod and Service

    kubectl get pods -n todoapp
    kubectl get svc -n todoapp
Expected: Pod in status Running
Service todoapp-service exists and exposes port 80 → 8080

Then test connectivity inside cluster:

    kubectl run curlpod --rm -it --image=curlimages/curl --restart=Never -- sh
    curl http://todoapp-service.todoapp.svc.cluster.local/health
Expected output: Healthy (or 200 OK response from the app)

## 3. Check if Ingress resource exists

    kubectl get ingress -n todoapp
Expect putput with NAME=ingress.

## 4. Port-forward to access Ingress

    kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 80:80
    curl -v http://localhost/
Ingress should correctly redirect traffic to the backend service and return a valid response (e.g. 200 OK).

After that, open http://localhost/ and inspect devtools → Network to ensure all static assets and API requests return 200 and no 404s.

## 5. Check for Ingress rule

    kubectl describe ingress ingress -n todoapp
Expected: only 1 HTTP rule is described under .spec.rules   
