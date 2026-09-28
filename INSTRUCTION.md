# INSTRUCTION.md

## 1. Create the Kind cluster

```bash
kind create cluster --config cluster.yml
```

## 2. Deploy the application and Ingress Controller

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

## 3. Validate the cluster

```bash
kubectl get nodes
```

## 4. Validate the application

```bash
kubectl get pods -n todoapp
kubectl get svc -n todoapp
```

The application Service should be available:

```text
todoapp-service
```

## 5. Validate Ingress

```bash
kubectl get ingress -n todoapp
```

Expected Ingress:

```text
my-ingress
```

Check the Ingress Controller:

```bash
kubectl get pods -n ingress-nginx
```

The Ingress Controller pod should have status `Running`.

## 6. Test the application

Open the following URL in a browser:

```text
http://localhost
```

The Todo App should be displayed.

Alternatively, test with:

```bash
curl http://localhost
```

## 7. Useful troubleshooting commands

```bash
kubectl describe ingress my-ingress -n todoapp
kubectl get endpoints todoapp-service -n todoapp
kubectl get pods -n todoapp -o wide
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller
```

```
