# Validation Instructions

## 1. Deploy Environment

Run the bootstrap script to provision the cluster, install the NGINX Ingress Controller, and deploy the application components.

```bash
sh bootstrap.sh
```

## 2. Validate Infrastructure
2.1 Check Ingress Controller

Ensure the NGINX controller pods are running in their dedicated namespace.

```bash
kubectl get pods -n ingress-nginx
```

2.2 Check Ingress Resource

Verify that your Ingress rule has been created and has acquired an address (localhost).
3.1 Browser Validation (Critical Step)

    Open your web browser.

    Navigate to: http://localhost

    You should see the ToDo application interface loaded successfully.

Check for 404 Errors:

    Open Developer Tools in your browser (Right-click -> Inspect, or F12).

    Go to the Network tab.

    Reload the page (F5 or Cmd+R).

    Verification: Look at the status codes for all resources (CSS, JS, Images).

        Success: All codes should be 200 or 304.

        Failure: If you see any red lines with 404 Not Found (especially for static files), it means the regex capture rule in ingress.yml is incorrect.