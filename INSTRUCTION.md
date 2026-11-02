# Instruction: how to validate the Ingress changes

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

## 1. Create the cluster

```
kind create cluster --config cluster.yml
```

## 2. Deploy the app and the Ingress controller

```
bash bootstrap.sh
```

This script deploys MySQL, the ToDo app, and the `ingress-nginx` controller, then applies `.infrastructure/ingress/ingress.yml`.

## 3. Wait for the Ingress controller to be ready

```
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s
```

## 4. Check that resources are up

```
kubectl get pods -n todoapp
kubectl get pods -n mysql
kubectl get pods -n ingress-nginx
kubectl get ingress -n todoapp
```

All pods should be in the `Running` state, and `kubectl get ingress -n todoapp` should show `example-ingress` with an assigned address.

## 5. Validate the app

Open [http://localhost](http://localhost) in the browser and confirm:

- The ToDo app landing page loads successfully.
- You can log in / use the app UI (create, update, delete tasks).
- The browser DevTools console (Network tab) shows no requests failing with a `404` status code.

## 6. Cleanup

```
kind delete cluster
```
