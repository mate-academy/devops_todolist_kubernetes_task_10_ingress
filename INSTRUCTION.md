# Instructions for Deploying and Validating Ingress Routing

## 1. How to Deploy
Execute the automated bootstrap script from the root directory:

```bash
./bootstrap.sh
```

---

## 2. How to Validate the Ingress Setup

### Step 2.1: Verify Ingress Controller and Resources
Ensure that the Ingress rule is correctly applied:
```bash
kubectl get ingress todoapp-ingress -n mateapp
```

### Step 2.2: Access the Application locally
Open your browser and navigate to:
http://localhost

### Step 2.3: Browser Console Check (No 404 Errors)
1. Open the browser Developer Tools (F12).
2. Switch to the Console and Network tabs.
3. Refresh the page and ensure that all static assets and API endpoints load successfully with a 200 OK status code. No 404 Not Found errors should be present.
