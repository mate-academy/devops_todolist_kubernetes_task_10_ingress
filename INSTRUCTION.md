## Create and deploy the cluster

From the repository root, create the cluster and run the bootstrap script:

```bash
kind create cluster --config cluster.yml
bash bootstrap.sh
```

The bootstrap script deploys MySQL, the ToDo application, the nginx ingress
controller, and the application ingress.

## Validate the deployment

Check that all nodes and application pods are ready:

```bash
kubectl get nodes
kubectl get pods -n mysql
kubectl get pods -n todoapp
kubectl get ingress -n todoapp
```

The ingress should use the `nginx` class and route `/` to
`todoapp-service:80`.

Check the application through the ingress:

```bash
curl -i http://localhost/
curl -i http://localhost/api/health
```

The first request should return the ToDo application page and the second
should return `HTTP/1.1 200 OK` with `Health OK` in the response body. The
browser console should contain no 404 requests for the application assets.

To remove the test cluster after validation:

```bash
kind delete cluster
```