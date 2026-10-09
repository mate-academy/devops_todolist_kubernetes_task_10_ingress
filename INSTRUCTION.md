# INSTRUCTION

## Validation

### 1. Start the Kind cluster

Start the Kubernetes cluster using the provided `cluster.yml` configuration:

```powershell
kind create cluster --config cluster.yml
```

Verify that the cluster is running:

```powershell
kubectl get nodes
```

### 2. Deploy the application and install NGINX Ingress Controller

Run the bootstrap script:

```powershell
bash .\bootstrap.sh
```

The script creates the MySQL resources, application resources, and installs the NGINX Ingress Controller.

Verify the Ingress Controller:

```powershell
kubectl get pods -n ingress-nginx
```

Wait until the Ingress Controller pod is in `Running` state.

### 3. Apply the Ingress manifest

Apply the Ingress resource:

```powershell
kubectl apply -f .\infrastructure\ingress\ingress.yml
```

Verify the Ingress:

```powershell
kubectl get ingress -A
```

### 4. Verify the application with curl

Check the application through the Ingress:

```powershell
curl.exe -v http://localhost/
```

The response should return HTTP status `200 OK` instead of `404 Not Found`.

### 5. Verify the application in a browser

Open the following address in a browser:

http://localhost/

The ToDo application should be displayed without a `404` error.

