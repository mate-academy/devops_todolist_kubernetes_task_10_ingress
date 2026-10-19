# How to validate the changes

## Prerequisites

- Docker, `kind`, `kubectl`
- Ports `80`, `443`, `30007`, `30008` free on the host

## Steps

1. Create the cluster from the config file:

   ```
   kind create cluster --config cluster.yml
   ```

2. Deploy the app, MySQL and the ingress controller:

   ```
   bash bootstrap.sh
   ```

3. Wait until the ingress controller is ready:

   ```
   kubectl wait --namespace ingress-nginx \
     --for=condition=ready pod \
     --selector=app.kubernetes.io/component=controller \
     --timeout=180s
   ```

4. Wait until the app pods are ready:

   ```
   kubectl get pods -n todoapp
   ```

5. Apply the Ingress:

   ```
   kubectl apply -f .infrastructure/ingress/ingress.yml
   ```

6. Check the Ingress was created and handled by the controller:

   ```
   kubectl get ingress -n todoapp
   kubectl get ingressclass
   ```

## Expected result

- Open `http://localhost` in the browser: the ToDo app landing page is shown.
- Open the browser developer console (Network / Console tab): there are no requests failing with status `404`.
- `curl -i http://localhost/api/health` returns `200`.

## Cleanup

```
kind delete cluster
```
