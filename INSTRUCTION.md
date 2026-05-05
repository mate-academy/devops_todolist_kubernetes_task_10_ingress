# Ingress Validation Instructions

## Prerequisites

- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) installed
- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed

---

## 1. Create the cluster

```bash
kind create cluster --config cluster.yml
```

The `cluster.yml` maps host port **80** → container port **80**, which is what allows `http://localhost` to reach the Ingress controller.

---

## 2. Bootstrap all resources

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

This applies all Kubernetes manifests (namespace, MySQL, app, services) and installs the **nginx Ingress controller**, then applies the Ingress rule from `.infrastructure/ingress/ingress.yml`.

---

## 3. Wait for the Ingress controller to be ready

```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
```

---

## 4. Verify the Ingress resource

```bash
kubectl get ingress -n todoapp
```

Expected output:

```
NAME               CLASS   HOSTS   ADDRESS     PORTS   AGE
todoapp-ingress    nginx   *       localhost   80      Xs
```

---

## 5. Validate the app is reachable

Open a browser and navigate to:

```
http://localhost
```

You should see the Todolist application running.

To verify there are no 404 errors:
1. Open **DevTools** → **Network** tab
2. Hard-refresh the page (`Ctrl+Shift+R`)
3. Confirm all requests return `200` (no `404` responses)

You can also use `curl`:

```bash
# Landing page
curl -s -o /dev/null -w "%{http_code}" http://localhost
# Expected: 200

# API endpoint
curl -s -o /dev/null -w "%{http_code}" http://localhost/api/
# Expected: 200
```

---

## 6. Tear down

```bash
kind delete cluster
```

---

## How the Ingress works

| Field | Value | Purpose |
|-------|-------|---------|
| `ingressClassName` | `nginx` | Targets the nginx Ingress controller installed by `bootstrap.sh` |
| `path` | `/(.*)` | Captures the full path including sub-paths (static assets, API, etc.) |
| `pathType` | `ImplementationSpecific` | Required for regex capture groups with nginx |
| `rewrite-target` | `/$1` | Forwards the captured path to the backend service as-is, preventing 404s on sub-paths |
| `service.name` | `todoapp-service` | ClusterIP service in the `todoapp` namespace |
| `service.port` | `80` | Service port (which forwards to container port `8080`) |
