# Task 10: Ingress

## Prerequisites

- Docker, [kind](https://kind.sigs.k8s.io/), `kubectl`
- Port **80** free on the host (used by kind `extraPortMappings` in `cluster.yml`)

## Deploy

From the repository root:

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

`bootstrap.sh`:

1. Creates the cluster: `kind create cluster --config cluster.yml`
2. Deploys MySQL (StatefulSet) and waits for **`mysql-0`**
3. Deploys the ToDo app (Deployment + ClusterIP Service)
4. Installs **ingress-nginx** for kind and waits for the controller pod
5. Applies **`.infrastructure/ingress/ingress.yml`**

If the cluster already exists:

```bash
kind delete cluster --name kind
```

## Ingress manifest (requirements)

| Requirement | Implementation |
|-------------|----------------|
| Path | `.infrastructure/ingress/ingress.yml` (README: `./infrastructure/ingress`; у цьому форку — `.infrastructure`, як `app/` і `mysql/`) |
| 1 HTTP rule | `rules[0].http` |
| 1 path rule | single entry under `paths` |
| Route `/` with path capture | regex `/(.*)` + `rewrite-target: /$1` |
| Backend | Service `todoapp-service:80` in `todoapp` |

Annotations (nginx ingress):

- `nginx.ingress.kubernetes.io/use-regex: "true"`
- `nginx.ingress.kubernetes.io/rewrite-target: /$1`

## Validate

### Ingress and controller

```bash
kubectl get ingress -n todoapp
kubectl get pods -n ingress-nginx
kubectl describe ingress todoapp-ingress -n todoapp
```

### App in the browser

Open [http://localhost/](http://localhost/) — the ToDo app landing page should load.

Check the browser **Network** tab (or DevTools console): static assets (`/static/...`, JS, CSS) should **not** return **404**. A broken Ingress rewrite often breaks `/static/` paths.

### curl

```bash
curl -sS -o /dev/null -w "%{http_code}\n" http://localhost/
curl -sS -o /dev/null -w "%{http_code}\n" http://localhost/api/health
```

Expect **200** (or **302** for `/` if redirected), not **404**.

### Optional: direct Service (debug)

```bash
kubectl port-forward -n todoapp service/todoapp-service 8080:80
curl -sS http://127.0.0.1:8080/api/health
```

## Clean up

```bash
kind delete cluster --name kind
```
