# Validation Instructions for ToDo App Kubernetes Ingress

This document provides step-by-step instructions to validate the Kubernetes ingress configuration for the Django ToDo application.

## Prerequisites

- Docker installed and running
- `kind` (Kubernetes in Docker) installed
- `kubectl` installed and configured

## Step 1: Create Kind Cluster

1. Create a Kubernetes cluster using the provided configuration:
   ```bash
   kind create cluster --config cluster.yml
   ```

2. Verify the cluster is running:
   ```bash
   kubectl cluster-info
   kubectl get nodes
   ```

## Step 2: Deploy Infrastructure

1. Make the bootstrap script executable:
   ```bash
   chmod +x bootstrap.sh
   ```

2. Run the bootstrap script to deploy MySQL, app infrastructure, and ingress controller:
   ```bash
   ./bootstrap.sh
   ```

3. Wait for the ingress controller to be ready:
   ```bash
   kubectl wait --namespace ingress-nginx \
     --for=condition=ready pod \
     --selector=app.kubernetes.io/component=controller \
     --timeout=90s
   ```

## Step 3: Deploy Ingress Configuration

1. Apply the ingress configuration:
   ```bash
   kubectl apply -f .infrastructure/ingress/ingress.yml
   ```

2. Verify the ingress was created successfully:
   ```bash
   kubectl get ingress
   kubectl describe ingress mate-ingress
   ```

## Step 4: Validation Tests

### 4.1 Check Pod Status
Verify all pods are running:
```bash
kubectl get pods --all-namespaces
```

All pods should show `Running` or `Completed` status.

### 4.2 Check Services
Verify services are properly configured:
```bash
kubectl get services --all-namespaces
```

Look for `todoapp-service` and ensure it has the correct port (80).

### 4.3 Check Ingress Status
```bash
kubectl get ingress -o wide
```

The ingress should show an ADDRESS (may take a few minutes to populate).

### 4.4 Test Application Access

1. **Primary Test**: Access the application via localhost:
   ```bash
   curl -I http://localhost
   ```
   Expected: HTTP 200 response

2. **Web Browser Test**: Open http://localhost in your browser
   - You should see the Django ToDo application
   - The page should load without any 404 errors in browser console

3. **API Endpoint Test**: Test the API endpoint:
   ```bash
   curl http://localhost/api/
   ```
   Expected: JSON response from the Django API

### 4.5 Browser Console Validation

1. Open browser developer tools (F12)
2. Navigate to the Network tab
3. Refresh the page at http://localhost
4. Verify there are NO requests with 404 status codes
5. Check the Console tab for any JavaScript errors

### 5.6 Path-based Routing Test

Test different paths to ensure the ingress routing works correctly:
```bash
# Test root path
curl -I http://localhost/

# Test API path
curl -I http://localhost/api/

# Test accounts path
curl -I http://localhost/accounts/

# Test static files
curl -I http://localhost/static/css/custom.css
```

All requests should return appropriate responses (200, 301, or 302 - NOT 404).
