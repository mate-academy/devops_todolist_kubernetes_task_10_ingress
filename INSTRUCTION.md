# Validation Instructions

```bash
kind create cluster --config cluster.yml --name todo-ingress
./bootstrap.sh
kubectl apply -f .infrastructure/ingress/ingress.yml
kubectl wait -n ingress-nginx --for=condition=ready pod -l app.kubernetes.io/component=controller --timeout=180s
curl -I http://localhost/
curl -I http://localhost/api/
```

Expected:
- `200 OK` from `http://localhost`
- App opens at [http://localhost](http://localhost)
- No `404` requests in browser DevTools (Console/Network)
