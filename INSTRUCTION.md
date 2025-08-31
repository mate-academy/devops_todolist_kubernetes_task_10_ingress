# Инструкции по валидации Kubernetes Ingress для Django ToDo приложения

## Обзор изменений

В рамках данного задания были внесены следующие изменения:

1. **Создана директория** `.infrastructure/ingress/` для хранения Ingress манифестов
2. **Создан файл** `.infrastructure/ingress/ingress.yml` с конфигурацией Ingress
3. **Обновлен скрипт** `bootstrap.sh` для автоматического применения Ingress конфигурации
4. **Добавлено ожидание** готовности NGINX Ingress Controller перед применением Ingress

## Предварительные требования

Перед началом валидации убедитесь, что у вас установлены:

- [Docker](https://docs.docker.com/get-docker/)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) (Kubernetes in Docker)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## Пошаговая валидация

### Шаг 1: Создание кластера

```bash
# Создайте кластер Kind с использованием конфигурационного файла
kind create cluster --config cluster.yml --name todoapp-cluster
```

**Ожидаемый результат:** Кластер должен быть успешно создан с настройками из `cluster.yml`, включая проброс портов 80 и 443.

### Шаг 2: Развертывание приложения

```bash
# Запустите скрипт развертывания
chmod +x bootstrap.sh
./bootstrap.sh
```

**Ожидаемый результат:**

- Все ресурсы MySQL и приложения должны быть успешно созданы
- NGINX Ingress Controller должен быть установлен и готов к работе
- Ingress ресурс должен быть применен без ошибок

### Шаг 3: Проверка статуса ресурсов

```bash
# Проверьте статус всех подов
kubectl get pods --all-namespaces

# Проверьте статус Ingress
kubectl get ingress -n todoapp

# Проверьте детали Ingress
kubectl describe ingress todoapp-ingress -n todoapp
```

**Ожидаемые результаты:**

- Все поды должны быть в статусе `Running`
- Ingress должен иметь назначенный адрес (обычно localhost или IP кластера)
- В описании Ingress должны быть видны правила маршрутизации

### Шаг 4: Проверка доступности приложения

```bash
# Проверьте доступность приложения через localhost
curl -I http://localhost

# Или откройте в браузере
# http://localhost
```

**Ожидаемые результаты:**

- HTTP запрос должен возвращать код ответа `200 OK`
- Приложение должно быть доступно в браузере по адресу `http://localhost`
- Главная страница Django ToDo приложения должна отображаться корректно

### Шаг 5: Проверка функциональности приложения

1. **Откройте браузер** и перейдите на `http://localhost`
2. **Проверьте навигацию** по различным страницам:

   - Главная страница (`/`)
   - API эндпоинт (`/api/`)
   - Страница регистрации (`/accounts/register/`)
   - Страница входа (`/accounts/login/`)

3. **Откройте инструменты разработчика** (F12) и перейдите на вкладку Network
4. **Обновите страницу** и убедитесь, что нет запросов с кодом ошибки 404

**Ожидаемые результаты:**

- Все страницы должны загружаться без ошибок
- В консоли браузера не должно быть 404 ошибок
- Статические файлы (CSS, JS, изображения) должны загружаться корректно

### Шаг 6: Проверка конфигурации Ingress

```bash
# Проверьте логи NGINX Ingress Controller
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller

# Проверьте события Ingress
kubectl get events -n todoapp --field-selector involvedObject.name=todoapp-ingress
```

**Ожидаемые результаты:**

- В логах не должно быть критических ошибок
- События должны показывать успешную синхронизацию Ingress

### Шаг 7: Тестирование path-based маршрутизации

```bash
# Тестирование различных путей
curl -I http://localhost/
curl -I http://localhost/api/
curl -I http://localhost/accounts/login/
curl -I http://localhost/static/css/custom.css
```

**Ожидаемые результаты:**

- Все запросы должны возвращать соответствующие HTTP коды (200, 301, 302)
- Не должно быть 404 ошибок для существующих ресурсов

## Проверка соответствия требованиям

### ✅ Требования выполнены:

1. **Ingress файл расположен** в директории `./infrastructure/ingress/` ✅
2. **Ingress имеет 1 HTTP правило** (без HTTPS) ✅
3. **Ingress имеет 1 path-based правило** с regex `/(.*)` ✅
4. **Правило маршрутизирует трафик** на приложение по корневому пути `/` ✅
5. **Правило захватывает путь** и перенаправляет его в приложение с помощью `rewrite-target` ✅
6. **Приложение доступно** по адресу `http://localhost` ✅
7. **Отсутствуют 404 ошибки** в браузерной консоли ✅

## Устранение неполадок

### Проблема: Приложение недоступно по localhost

**Решение:**

```bash
# Проверьте проброс портов в кластере
kubectl get nodes -o wide

# Проверьте статус Ingress Controller
kubectl get pods -n ingress-nginx

# Перезапустите Ingress Controller если необходимо
kubectl rollout restart deployment/ingress-nginx-controller -n ingress-nginx
```

### Проблема: 404 ошибки для статических файлов

**Решение:**

```bash
# Проверьте конфигурацию Django для статических файлов
kubectl logs -n todoapp deployment/todoapp

# Убедитесь, что rewrite-target правильно настроен
kubectl describe ingress todoapp-ingress -n todoapp
```

### Проблема: Поды не запускаются

**Решение:**

```bash
# Проверьте логи подов
kubectl logs -n todoapp deployment/todoapp
kubectl logs -n mysql statefulset/mysql

# Проверьте ресурсы кластера
kubectl top nodes
kubectl top pods --all-namespaces
```

## Очистка ресурсов

После завершения валидации удалите кластер:

```bash
kind delete cluster --name todoapp-cluster
```

## Заключение

Если все шаги валидации прошли успешно, то Ingress конфигурация работает корректно и соответствует всем требованиям задания. Приложение должно быть доступно через `http://localhost` без каких-либо 404 ошибок.
