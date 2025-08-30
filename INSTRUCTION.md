# DevOps ToDo List - Kubernetes & Ingress Setup

## Prerequisites

- Docker installed
- kind (Kubernetes IN Docker) installed
- Kubernetes cluster (Minikube, Docker Desktop, or cloud provider)
- kubectl CLI
- Python 3.8+
- Git

## 1. Create Kubernetes Cluster

```sh
kind create cluster --config cluster.yml
```

## 2. Clone the Repository

```sh
git clone <your-repo-url>
cd devops_todolist_kubernetes_task_10_ingress
```

## 3. Deploy Application & Ingress

Run the bootstrap script to deploy all resources and install the ingress controller:

```sh
bash bootstrap.sh
```

This will:
- Create namespaces
- Deploy MySQL and the application
- Install/configure the NGINX ingress controller

## 4. Access the Application

- Find the ingress IP or domain:
  ```sh
  kubectl get ingress -n <namespace>
  ```
- Open in browser: `http://localhost/`

**Validation:**  
- Confirm the app loads at `http://localhost`.
- Check browser console/network for absence of HTTP 404s on static assets and API calls.

## 5. Useful Commands

- View pods:
  ```sh
  kubectl get pods -n <namespace>
  ```
- View services:
  ```sh
  kubectl get svc -n <namespace>
  ```
- View logs:
  ```sh
  kubectl logs <pod-name> -n <namespace>
  ```

## 6. Troubleshooting

- Check pod status:
  ```sh
  kubectl describe pod <pod-name> -n <namespace>
  ```
- Check events:
  ```sh
  kubectl get events -n <namespace>
  ```

---

For more details, check the manifests in `.infrastructure/` and source code in `src/`.