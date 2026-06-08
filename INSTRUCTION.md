# Validation Instructions

## Prerequisites

- `kubectl` configured and connected to your cluster
- All manifest files present in the `.infrastructure` directory

---

## 1. Deploy all resources

```bash
./bootstrap.sh
```

---

## 2. Validate Resources

```bash
kubectl get ns
kubectl get pods -n todoapp
kubectl get svc -n todoapp
kubectl get secrets -n todoapp
kubectl get configmap -n todoapp
```

**Expected:** Both `ingress-nginx` and `todoapp` namespaces are listed, 2 `todoapp-*****-******` pods running,
`app-secret` secret, `app-config` config map

---

## 3: Validate Ingress Configuration

```bash
kubectl describe ingress todo-ingress -n todoapp
```

**Expected:** The Path is defined as a regex pattern (e.g., /(.\*) mapping to todoapp-service).
The annotation `nginx.ingress.kubernetes.io/rewrite-target` is appropriately aligned (/$1).

## 4: End-to-End Traffic Routing Validation

```bash
kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 8080:80
curl -I http://localhost:8080
```

**Expected:** An HTTP response status code of 200 OK.
