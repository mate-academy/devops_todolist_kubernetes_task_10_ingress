# ToDo App Deployment Validation Guide

This guide provides instructions on how to deploy the infrastructure and validate the Ingress configuration.

## 1. Cluster Initialization
Spin up the cluster using the provided configuration file. This file ensures that ports 80 and 443 are mapped from your host to the control-plane node.

`kind create cluster --config cluster.yml`

## 2. Infrastructure Deployment
Run the bootstrap script to deploy the MySQL database, the ToDo application, and the Nginx Ingress Controller:

`./bootstrap.sh`

## 3. Validation Steps
Resource Status Check
Ensure all components are operational. Run the following commands:

App Pods: `kubectl get pods -n todoapp `(Status: Running)

Ingress Controller: `kubectl get pods -n ingress-nginx` (Status: Running)

## 4. Accessing the Application
Open your web browser and navigate to:
http://localhost