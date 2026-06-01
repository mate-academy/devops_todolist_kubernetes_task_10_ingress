## Instruction on how to validate the changes
1. Run Docker 
2. Create a cluster:
```bash
kind create cluster --config cluster.yml
```
3. Run Deploy:
```bash
bash bootstrap.sh
```
4. Use Ingress:
```bash
kubectl apply -f infrastructure/ingress/ingress.yml
```