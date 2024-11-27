# Ingress for TodoApp

## 1. Start a cluster:
```bash
kind create cluster --config cluster.yml
```

## 2. Deploy Todoapp and all the additional resources:
```bash
bootstrap.sh
```

## 3. Access the app in your web browser at http://localhost

## 4. Validation:
Create some to-do lists to ensure the app is running correctly. Lists are created at http://localhost/todolist/1, http://localhost/todolist/2, etc.
Test the routing by accessing the app at different paths that are supported by the application (e.g., /1, /2, or any other valid paths that exist).
