How to validate the changes

Create the kind cluster
From the repository root, run:

kind create cluster --config cluster.yml

Expected result:
Set kubectl context to "kind-kind"
You can now use your cluster with:
kubectl cluster-info --context kind-kind

Deploy the application
Run:

./bootstrap.sh

If deployment fails
Check the status of the resources:

kubectl get pods -A
kubectl get events -A --sort-by=.lastTimestamp

For a failed application pod, inspect its description and logs:

kubectl describe pod -n todoapp <pod-name>
kubectl logs -n todoapp <pod-name> --previous

For Ingress problems, check:

kubectl get ingress -n todoapp
kubectl describe ingress -n todoapp todoapp-ingress
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller

Fix the reported problem and run the failed deployment command again.

Check for 404 responses
Open `http://localhost/` in a browser.
Open Developer Tools with `F12`, select the **Network** tab, reload the page, and check that requests for the page and its assets do not have status `404`.
You can also check the main response from the terminal:

curl -I http://localhost/

Expected result:
HTTP/1.1 200 OK
There should be no failed requests with status 404 in the browser Network tab.