# run cluster

```
kind create cluster --name todoapp-cluster --config cluster.yml

```

# run script

```
./bootstrap.sh
```

# Create ingress
```
kubectl apply -f .infrastructure/ingress/ingress.yml
```

# check where we dont have truble
http://localhost 


