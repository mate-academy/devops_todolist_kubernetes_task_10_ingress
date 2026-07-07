# Validation Instructions

## Create the kind cluster

Create a fresh kind cluster from the provided configuration file:

```bash
kind create cluster --config cluster.yml
```

The `cluster.yml` file maps ports `80` and `443` from the kind control-plane node to localhost, so the Ingress can be reached at `http://localhost`.

## Deploy the application

Apply all Kubernetes manifests and install the nginx Ingress controller:

```bash
bash bootstrap.sh
```

The script applies the MySQL manifests, the ToDo app manifests, the app `Deployment` from `.infrastructure/app/deployment.yml`, and the Ingress from `.infrastructure/ingress/ingress.yml`.

## Verify Kubernetes resources

Check that the app pods are running:

```bash
kubectl get pods -n todoapp
```

Check that the Service has endpoints:

```bash
kubectl get svc,endpoints -n todoapp
```

Check that the nginx Ingress controller is ready:

```bash
kubectl get pods -n ingress-nginx
```

Check that the Ingress was created:

```bash
kubectl get ingress -n todoapp
```

## Verify the app in the browser

Open:

```text
http://localhost
```

The ToDo app should load successfully.

You can also verify the health endpoint:

```bash
curl http://localhost/api/health
```

Expected response:

```text
Health OK
```

Finally, open the browser developer console and confirm that no requests fail with a `404` status code.
