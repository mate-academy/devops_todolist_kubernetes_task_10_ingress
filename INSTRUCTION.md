# Validation Instructions

## 1. Create kind cluster

```bash
kind create cluster --name todoapp --config cluster.yml
```

Verify:

```bash
kind get clusters
kubectl config current-context
```

Expected: cluster `todoapp` exists and context points to `kind-todoapp`.

## 2. Deploy application and ingress controller

```bash
./bootstrap.sh
```

Verify pods:

```bash
kubectl get pods -n mysql
kubectl get pods -n todoapp
kubectl get pods -n ingress-nginx
kubectl get pods -n ingress-nginx -o wide
```

Expected: all pods are `Running` and `READY`.
Expected: `ingress-nginx-controller` runs on `todoapp-control-plane`.

## 3. Apply Ingress

```bash
kubectl apply -f .infrastructure/ingress/ingress.yml
kubectl get ingress -n todoapp
```

Expected: ingress `todoapp-ingress` exists.

## 4. Validate app via localhost

Open in browser:

- http://localhost/

Expected: ToDo app page is loaded.

## 5. Validate no 404 in browser console

In browser DevTools:

1. Open `Network` tab.
2. Reload page `http://localhost/`.
3. Filter by `Status Code = 404`.

Expected: no failed requests with `404`.

## 6. Optional CLI smoke checks

```bash
curl -I http://localhost/
curl -I http://localhost/api/
curl -I http://localhost/static/css/custom.css
```

Expected: HTTP status `200`.
