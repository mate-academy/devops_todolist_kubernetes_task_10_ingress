#!/bin/bash

# Apply all YAML files in the specified directories
apply_files_in_directory() {
    local directory=$1
    echo "Applying files in directory: $directory"
    for file in "$directory"/*.yml; do
        if [ -f "$file" ]; then
            echo "Applying $file..."
            kubectl apply -f "$file"
        else
            echo "No YAML files found in $directory"
        fi
    done
}

# Directories to apply
APP_DIR="./.infrastructure/app"
MYSQL_DIR="./.infrastructure/mysql"
INGRESS_DIR="./.infrastructure/ingress"

# Validate MySQL Configurations
echo "Validating MySQL Configurations..."

# Apply files in the app directory
apply_files_in_directory "$APP_DIR"

# Apply files in the mysql directory
apply_files_in_directory "$MYSQL_DIR"

# Ingress Setup
echo "Validating Ingress Setup..."

# Apply files in the ingress directory
apply_files_in_directory "$INGRESS_DIR"

# Validate MySQL StatefulSet
echo "Validating MySQL StatefulSet..."
kubectl rollout status statefulset/mysql -n mysql

# Validate Pods
echo "Checking Pods in the mysql namespace..."
kubectl get pods -n mysql

# Validate Services
echo "Checking Services in the mysql namespace..."
kubectl get svc -n mysql

# Validate Ingress
echo "Validating Ingress..."
kubectl get ingress -n todoapp

echo "Validation Completed."

# Instructions for User to Access ToDo App
echo "Access the ToDo Application at http://localhost"
echo "Open your browser and navigate to http://localhost. You should see the ToDo app running."
echo "Check for 404 Errors in the browser console to ensure there are no requests failing with a 404 status code."
