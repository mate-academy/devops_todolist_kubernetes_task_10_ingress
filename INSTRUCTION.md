# Інструкції для перевірки ingress

# Застосувати Ingress:
   kubectl apply -f ingress.yml

# Перевірити, що Ingress створений:
kubectl get ingress
# Має бути вивід з ім’ям todo-ingress.

# Переконатися, що Ingress-контролер запущений:
kubectl get pods -n ingress-nginx

# Має бути pod з назвою, що містить controller і статусом Running.
# Відкрити браузер і перейти за адресою:
http://localhost/
# Має відобразитись додаток ToDo, що працює через сервіс kube2py-blue-service.

# Якщо не працює, перевірити логи Ingress-контролера:
kubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller

# Якщо кластер створено за допомогою kind, перевірити, що порт 80 проброшений:
cat cluster.yml

# Має бути секція:
extraPortMappings:
- containerPort: 80
  hostPort: 80
  protocol: TCP