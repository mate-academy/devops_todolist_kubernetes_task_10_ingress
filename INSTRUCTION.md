# INSTRUCTION

## Prerequisites

Make sure the following tools are installed and running:

- Docker Desktop
- Kubernetes CLI (`kubectl`)
- kind
- Git Bash (for running the bootstrap script on Windows)

## 1. Start Docker Desktop

Start Docker Desktop and make sure Docker Engine is running.

Verify Docker:

```bash
docker version
```

## 2. Create the Kubernetes Cluster

Create a local Kubernetes cluster using the provided `cluster.yml` configuration:

```bash
kind create cluster --config cluster.yml
```

Verify the cluster:

```bash
kubectl get nodes
```

All nodes should have the `Ready` status.

## 3. Deploy the Application and Ingress Controller

Run the bootstrap script from the project root directory:

```bash
bash ./bootstrap.sh
```

The script deploys the MySQL database, Django application resources, and the NGINX Ingress Controller.

## 4. Deploy the Ingress Resource

Apply the Ingress manifest:

```bash
kubectl apply -f .infrastructure/ingress/ingress.yml
```

Verify the Ingress resource:

```bash
kubectl get ingress -n todoapp
```

Inspect its configuration:

```bash
kubectl describe ingress todoapp-ingress -n todoapp
```

## 5. Verify Kubernetes Resources

Check application pods:

```bash
kubectl get pods -n todoapp
```

Check the Ingress Controller:

```bash
kubectl get pods -n ingress-nginx
```

Check application services:

```bash
kubectl get services -n todoapp
```

The application pods and Ingress Controller should be in the `Running` state.

## 6. Access the Application

Open the following URL in your browser:

http://localhost

The Django ToDo application landing page should be displayed.

## 7. Verify Browser Requests

Open Developer Tools in your browser by pressing `F12`.

1. Open the **Console** tab.
2. Open the **Network** tab.
3. Reload the application page.
4. Check that there are no failed requests with HTTP `404` status codes.

## 8. Troubleshooting

To inspect application pods:

```bash
kubectl get pods -n todoapp
```

To inspect Ingress Controller logs:

```bash
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller
```

To inspect Ingress configuration:

```bash
kubectl describe ingress todoapp-ingress -n todoapp
```

To check the application service endpoints:

```bash
kubectl get endpoints todoapp-service -n todoapp
```