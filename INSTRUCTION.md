# Validate Ingress

## 1. Create the cluster
```bash
kind create cluster --config cluster.yml
kubectl config use-context kind-kind
```

## 2. Deploy app, MySQL, ingress controller and Ingress
```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

## 3. Check resources
```bash
kubectl get pods -n mysql
kubectl get pods -n todoapp
kubectl get pods -n ingress-nginx
kubectl get ingress -n todoapp
```
All pods should be `Running`, the `todoapp-ingress` should exist with class `nginx`.

## 4. Check the app
```bash
curl -I http://localhost/
curl -I http://localhost/api/
```
Open http://localhost in the browser → the ToDo app is shown.
Open DevTools → Network/Console → reload: there must be no 404 requests.

## Ingress details
- File: `infrastructure/ingress/ingress.yml`
- 1 HTTP rule, 1 path-based rule: `path: /(.*)`, `pathType: ImplementationSpecific`
- `nginx.ingress.kubernetes.io/use-regex: "true"` + `rewrite-target: /$1` — the captured path is forwarded to `todoapp-service:80` unchanged.