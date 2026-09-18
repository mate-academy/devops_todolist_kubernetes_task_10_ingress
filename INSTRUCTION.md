# Validation Instructions

Follow these steps to validate the Ingress deployment for the ToDo application:

1. **Create the local cluster:**
   Spin up the cluster using the provided configuration file to ensure port 80 is mapped correctly:
   `kind create cluster --config cluster.yml`

2. **Deploy the application:**
   Run the bootstrap script to deploy the application resources and install the NGINX Ingress controller:
   `bash bootstrap.sh`

3. **Apply the Ingress rule:**
   Apply the newly created Ingress manifest to route the traffic:
   `kubectl apply -f .infrastructure/ingress/ingress.yml`

4. **Verify application access:**
   - Open a web browser (use an Incognito/Private window if necessary).
   - Navigate to `http://localhost`.
   - The Django ToDo application landing page should load successfully.

5. **Verify path-based routing (No 404 Errors):**
   - Open the browser's Developer Tools (press F12 or right-click and select "Inspect").
   - Navigate to the "Console" or "Network" tab.
   - Refresh the page (F5).
   - Confirm that there are no red 404 (Not Found) errors, meaning the regex path rule correctly loaded all CSS and JavaScript files.