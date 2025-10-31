# Інструкції з Валідації Django ToDo App на Kubernetes

Цей посібник охоплює всі кроки, необхідні для розгортання та валідації функціональності Ingress відповідно до вимог завдання.

## 1 Налаштування Кластера та Ingress Controller

1.  **Створіть кластер Kind** з мапінгом портів 80/443 (як визначено у `cluster.yml`). Якщо кластер з іменем `kind` вже існує, видаліть його спочатку.
    ```bash
    kind delete cluster --name kind
    kind create cluster --config cluster.yml
    ```

2.  **Запустіть Bootstrap-скрипт** для встановлення всіх необхідних залежностей, включаючи NGINX Ingress Controller:
    ```bash
    ./bootstrap.sh
    ```

## 2 Розгортання Додатку та Ingress-Правила

1.  **Розгорніть Pod та Service** (за умови, що ви використовуєте оновлений `todo-pod.yml` з робочим образом, наприклад, `hashicorp/http-echo`, якщо оригінальний образ не працює):
    ```bash
    kubectl apply -f todo-pod.yml
    ```

2.  **Створіть каталог** для Ingress-файлу:
    ```bash
    mkdir -p infrastructure/ingress
    ```

3.  **Розгорніть Ingress-правила**, використовуючи файл `infrastructure/ingress/ingress.yml` (він має містити `pathType: ImplementationSpecific` та анотації `rewrite-target` та `use-regex`).
    ```bash
    kubectl apply -f infrastructure/ingress/ingress.yml
    ```

## 3 Валідація Розгортання та Доступу

### А. Перевірка Статусу Ресурсів

Переконайтеся, що всі ключові компоненти працюють:
```bash
kubectl get pods -o wide
# Очікуваний результат: Pod "todoapp" повинен мати статус 1/1 Running.

kubectl get ingress
# Очікуваний результат: Ingress "todoapp-ingress" має бути створений.

Звісно. Ось вміст файлу INSTRUCTION.md з докладними інструкціями для валідації змін, відповідно до вимог завдання.

📝 INSTRUCTION.md
Markdown

# Інструкції з Валідації Django ToDo App на Kubernetes

Цей посібник охоплює всі кроки, необхідні для розгортання та валідації функціональності Ingress відповідно до вимог завдання.

## 1) Налаштування Кластера та Ingress Controller

1.  **Створіть кластер Kind** з мапінгом портів 80/443 (як визначено у `cluster.yml`). Якщо кластер з іменем `kind` вже існує, видаліть його спочатку.
    ```bash
    kind delete cluster --name kind
    kind create cluster --config cluster.yml
    ```

2.  **Запустіть Bootstrap-скрипт** для встановлення всіх необхідних залежностей, включаючи NGINX Ingress Controller:
    ```bash
    ./bootstrap.sh
    ```

## 2) Розгортання Додатку та Ingress-Правила

1.  **Розгорніть Pod та Service** (за умови, що ви використовуєте оновлений `todo-pod.yml` з робочим образом, наприклад, `hashicorp/http-echo`, якщо оригінальний образ не працює):
    ```bash
    kubectl apply -f todo-pod.yml
    ```

2.  **Створіть каталог** для Ingress-файлу:
    ```bash
    mkdir -p infrastructure/ingress
    ```

3.  **Розгорніть Ingress-правила**, використовуючи файл `infrastructure/ingress/ingress.yml` (він має містити `pathType: ImplementationSpecific` та анотації `rewrite-target` та `use-regex`).
    ```bash
    kubectl apply -f infrastructure/ingress/ingress.yml
    ```

## 3) Валідація Розгортання та Доступу

### А. Перевірка Статусу Ресурсів

Переконайтеся, що всі ключові компоненти працюють:
```bash
kubectl get pods -o wide
# Очікуваний результат: Pod "todoapp" повинен мати статус 1/1 Running.

kubectl get ingress
# Очікуваний результат: Ingress "todoapp-ingress" має бути створений.

##Б. Перевірка Доступу через Ingress (Критерії Проходження)
Перевірте доступ до додатка через http://localhost. Це підтвердить, що NGINX Ingress Controller коректно маршрутизує трафік.

Тест Кореневого Шляху (/):

Bash

curl http://localhost
# Очікуваний результат: Успішна відповідь від додатка (або повідомлення від echo-сервера).
Тест Дочірнього Шляху (/api/): Цей тест підтверджує, що анотація rewrite-target: /$2 працює коректно, і додаток не повертає помилку 404 для будь-яких шляхів.

Bash

curl http://localhost/api/
# Очікуваний результат: Успішна відповідь від додатка (те саме повідомлення, що і для кореня).
Критерій успіху: Додаток відповідає успішно на http://localhost та http://localhost/api/ без отримання статусу HTTP 404.