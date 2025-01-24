## How to validate changes

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   cd <repo-name>
2. Create a cluster using kind:
    ```bash
   kind create cluster --config cluster.yml
3. Run the bootstrap script:
    ```bash
   ./bootstrap.sh
4. Deploy the Ingress:
    ```bash
   kubectl apply -f infrastructure/ingress/ingress.yml
5. Access the application: Open http://localhost in a browser and ensure the app is running without 404 errors in the console.
