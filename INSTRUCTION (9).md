# Instruction: how to validate the Ingress changes

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

## Note on the directory name (`.infrastructure` vs `infrastructure`)

The task description mentions `./infrastructure/ingress`, but this is a typo in the README. In this repository the directory is named **`.infrastructure`** (with a leading dot), and this is the only directory that exists in the repo:

- `bootstrap.sh` (provided with the task) applies every manifest from `.infrastructure/...` (MySQL, app, and Ingress).
- The existing manifests (`.infrastructure/app/`, `.infrastructure/mysql/`) already live there.

The Ingress is therefore placed at **`.infrastructure/ingress/ingress.yml`**, next to the other manifests, so that `bootstrap.sh` finds and applies it. Creating a separate `infrastructure/` directory would make `bootstrap.sh` fail with "path does not exist" and the Ingress would not be deployed.

## 1. Create the cluster

```
kind create cluster --config cluster.yml
```

## 2. Deploy the app and the Ingress controller

```
bash bootstrap.sh
```

This script deploys MySQL, the ToDo app, and the `ingress-nginx` controller, then applies the Ingress from `.infrastructure/ingress/ingress.yml`.

## 3. Wait for the Ingress controller to be ready

```
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s
```

If `bootstrap.sh` reported an error for the Ingress (the controller's admission webhook was not ready yet), re-apply it:

```
kubectl apply -f .infrastructure/ingress/ingress.yml
```

## 4. Check that resources are up

```
kubectl get pods -n todoapp
kubectl get pods -n mysql
kubectl get pods -n ingress-nginx
kubectl get ingress -n todoapp
```

All pods should be in the `Running` state, and `kubectl get ingress -n todoapp` should show `todoapp-ingress` with the `/` path rule.

## 5. Validate the app

Open [http://localhost](http://localhost) in the browser and confirm:

- The ToDo app landing page loads successfully.
- The app UI works (create, update, delete tasks).
- The browser DevTools console / Network tab shows no requests failing with a `404` status code.

## 6. Cleanup

```
kind delete cluster
```
