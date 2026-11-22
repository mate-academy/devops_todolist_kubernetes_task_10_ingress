# Launching and deploying the ToDo application in a Kubernetes cluster. 

## Create a cluster by running the following command:
```
kind create cluster --name ingresscluster --config cluster.yml
```

## You can obtain all the necessary components by running the script:
```
bash bootstrap.sh
```
### Important!

You must wait until all database and application components have started. 
Check
``` 
kubectl get pods -n mysql 
kubectl get pods -n todoapp
```

The "Ready" status is expected for all pod groups.

Next, you need to generate the ingress manifest for the ToDo app by running the following command:
```
kubectl apply -f .infrastructure/ingress/ingress.yml
```

If the deployment is successful, opening the page http://localhost in a browser should redirect to the production application. There should be no requests with a 404 status.

Or run
```bash
curl -i http://localhost
```
Expected result: an `HTTP/1.1 200 OK` response with the application's HTML page.

## Delete the cluster after verification

```bash
kind delete cluster --name ingresscluster
```