# Validation Instructions

Follow these steps to validate the Ingress deployment for the ToDo application:

1. **Create the local cluster:**
   Spin up the cluster using the provided configuration file. 
   *Important:* Verify that your `cluster.yml` includes the `extraPortMappings` to map container port 80 to your `localhost:80` before running this command.
   `kind create cluster --config cluster.yml`

2. **Deploy the application and Ingress:**
   Run the bootstrap script. This script automatically deploys all application resources, installs the NGINX Ingress controller, and applies the required ingress manifest.
   `bash bootstrap.sh`

3. **Verify application access:**
   - Open a web browser (use an Incognito/Private window to prevent automatic HTTPS redirects).
   - Navigate to `http://localhost`.
   - The Django ToDo application landing page should load successfully.

4. **Verify path-based routing (No 404 Errors):**
   - Open the browser's Developer Tools (press F12).
   - Navigate to the "Console" or "Network" tab and refresh the page (F5).
   - Confirm there are no 404 (Not Found) errors. 
   - *Technical Note:* The Ingress is configured with the regular expression `/(/|$)(.*)` (enabled via the `use-regex: "true"` annotation). This properly captures the root path and forwards all subsequent traffic, including static assets like CSS and JS, to the `todoapp-service` on port 80.