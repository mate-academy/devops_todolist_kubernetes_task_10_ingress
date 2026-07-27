# Інструкція з перевірки та розгортання проєкту

Запуск кластера та додатків

```bash
kind create cluster --config cluster.yml
bash bootstrap.sh

# Після того, як поди перейдуть у стан Running, 
kubectl get pods -n todoapp
# застосуйте маніфест Ingress:
kubectl apply -f .infrastructure/ingress/ingress.yml

# Перевірте стан Ingress-ресурсу: 
kubectl get ingress -n todoapp

# Для перевірки доступності додатка виконайте запит у терміналі:
curl -I http://localhost або відкрийте у браузері за адресою: http://localhost
