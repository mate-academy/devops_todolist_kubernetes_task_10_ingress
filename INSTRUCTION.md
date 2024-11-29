# Instructions for checking changes

# Run the script to configure the cluster. This can be done using the following command:

./bootstrap.sh

# Creating an Ingress

kubectl apply -f ./.infrastructure/ingress/ingress.yml

# Verify that the Ingress was created successfully:

kubectl get ingress todoapp-ingress

# Checking the application

http://localhost
http://localhost/Prefix
