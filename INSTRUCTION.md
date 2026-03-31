To check how ingress works use command:

    bash ./bootstrap.sh

    cd ./infrastructure/app

    kubectl port-forward deployments/deployment.yml 8080:8080 -- sh

Then open browser and go to localhost:8080/hellomates