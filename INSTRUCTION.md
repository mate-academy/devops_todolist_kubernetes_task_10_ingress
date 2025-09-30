# Instructions to Validate the ToDo App Deployment

Follow these steps to validate that the ToDo application is accessible through the Ingress.

## 1. Access the App via Ingress

1. Port-forward the ingress controller to your local machine:

```bash
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8080:80
````

2. Open your web browser and navigate to:

```
http://localhost:8080/
```

3. Verify that the ToDo app is running and accessible.

   * Make sure there are no requests failing with `404` in the browser console.
   * The app should fully load and function correctly.
