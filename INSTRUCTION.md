# INSTRUCTION.md

## Validation Instructions

Follow the steps below to validate the Kubernetes setup for the Django ToDo List application:

### Prerequisites

- Ensure you have `kubectl` installed and configured.
- Ensure `kind` (Kubernetes in Docker) is installed.
- Clone the repository and navigate to its root directory.
- Ensure the necessary base64-encoded secrets have been configured in the `secret.yml` files.

### Steps

1. **Spin Up the Kubernetes Cluster**

   Use the provided `cluster.yml` file to create a Kubernetes cluster:
   ```bash
   kind create cluster --config cluster.yml
   ```

2. **Deploy the Application**

   Run the `bootstrap.sh` script to deploy the application resources:
   ```bash
   ./bootstrap.sh
   ```

   This script will:
   - Create namespaces for `todoapp` and `mysql`.
   - Deploy MySQL resources (ConfigMap, Secret, Service, StatefulSet).
   - Deploy the Django ToDo application resources (ConfigMap, Secret, Deployment, Services, HPA, PVC, PV).
   - Install the NGINX ingress controller.

3. **Create and Apply the Ingress Resource**

   Create the `ingress.yml` file in the `.infrastructure/ingress` directory with the following specifications:
   - One HTTP rule.
   - One path-based rule routing traffic to the `/` path.
   - Use the regex `{your_regex}` to capture the path.

   Apply the ingress resource:
   ```bash
   kubectl apply -f .infrastructure/ingress/ingress.yml
   ```

4. **Validate the Application**

   - Access the application in your browser at `http://localhost`.
   - Confirm that the application loads without any 404 errors in the browser console.
   - Check the API at `http://localhost/api/` to ensure it is operational.

5. **Verify the Pods and Services**

   Check the status of all pods and services:
   ```bash
   kubectl get pods --all-namespaces
   kubectl get svc --all-namespaces
   ```

6. **Scaling and Probes**

   - Confirm that the Horizontal Pod Autoscaler (HPA) scales the application pods based on CPU and memory utilization.
   - Verify the liveness and readiness probes by inspecting pod events:
     ```bash
     kubectl describe pod <pod_name>
     ```

7. **Clean Up**

   If validation is complete, delete the cluster:
   ```bash
   kind delete cluster
   
