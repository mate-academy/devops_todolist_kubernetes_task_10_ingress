## Kubernetes task 10 — Ingress

### 1) Create kind cluster

```bash
kind create cluster --config cluster.yml
```

### 2) Deploy app + install ingress controller + ingress rule

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

Wait for ingress-nginx controller:

```bash
kubectl -n ingress-nginx rollout status deployment/ingress-nginx-controller
```

### 3) Validate ingress
Check resources:

```bash
kubectl -n todoapp get svc,deploy,pods,ingress
kubectl -n todoapp describe ingress todoapp
```

Open the app in browser:
- `http://localhost/`

Or test with curl:

```bash
curl -i http://localhost/
curl -i http://localhost/api/health
curl -i http://localhost/api/ready
```

Expected:
- App UI is served on `/`
- API endpoints respond via ingress
- No 404 requests in browser console (all paths are forwarded by regex rule)

