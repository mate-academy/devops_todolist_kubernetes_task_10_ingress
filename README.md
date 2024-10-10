# Deployment Guide
1. **Create cluster**
    ```sh
    kind create cluster --config cluster.yml
    ```

2. **Apply all manifests**
    ```sh
    ./bootstrap.sh
    ```

## Verification

1. **Check Pods**
    ```sh
    kubectl get pods -n todoapp
    kubectl get pods -n mysql
    kubectl get pods -n ingress-nginx
    ```

2. **Check Logs**
    ```sh
    kubectl logs <name_of_pod> -n <namespace>
    ```

3. **Check Ingress**
    ```sh
    kubectl get ingress
    ```

4. **Check browser**
    ```sh
    http://localhost/
    ```
