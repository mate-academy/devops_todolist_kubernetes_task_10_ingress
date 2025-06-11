# INSTRUCTION.md

## Validation Instructions

This document explains how to validate the changes made for deploying the ToDo app using a Kubernetes cluster with Ingress.

---

## 1. Verify Repository Structure

Ensure that the following structure is present:

```
./
├── bootstrap.sh
├── cluster.yml
└── infrastructure/
    └── ingress/
        └── ingress.yml
```

---

## 2. Create and Start the Kubernetes Cluster

Use `kind` to create the cluster using the provided configuration:

```bash
kind create cluster --config cluster.yml
```

---

## 3. Deploy Application and Ingress Controller

Run the bootstrap script to deploy the ToDo app and install the ingress controller:

```bash
./bootstrap.sh
```

---

## 4. Check the Ingress Configuration

Ensure the `ingress.yml` file exists at:

```
./infrastructure/ingress/ingress.yml
```

The Ingress must:

- Contain **one HTTP rule**
- Include **one path-based rule**
- Match requests with path: `/todoapp(/|$)(.*)`
- Rewrite the path using the annotation `nginx.ingress.kubernetes.io/rewrite-target: /$2`
- Route traffic to the backend service `todoapp-service` on port `80`

Apply the Ingress resource:

```bash
kubectl apply -f ./infrastructure/ingress/ingress.yml
```

---

## 5. Validate Application Access

Open a web browser and navigate to:

```
http://localhost/todoapp
```

You should see the ToDo app interface.

---

## 6. Check for Errors

Open your browser’s developer console and inspect the **Network** tab.

### ✅ Success Criteria:

- The ToDo app is fully accessible at `http://localhost/todoapp`
- There are **no requests failing with HTTP 404**
- All static assets load correctly
- Routing and UI functionality operate as expected

---

## 7. Cleanup (Optional)

To remove the local cluster when you're done testing:

```bash
kind delete cluster
```

---

## 8. Submit for Review

Once validation is complete:

1. Push your changes to your forked repository
2. Create a Pull Request (PR)
3. Attach the PR for validation on the required platform
