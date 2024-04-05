# Django ToDo list

This is a todo list web application with basic features of most web apps, i.e., accounts/login, API, and interactive UI. To do this task, you will need:

- CSS | [Skeleton](http://getskeleton.com/)
- JS | [jQuery](https://jquery.com/)

## Explore

Try it out by installing the requirements (the following commands work only with Python 3.8 and higher, due to Django 4):

```
pip install -r requirements.txt
```

Create a database schema:

```
python manage.py migrate
```

And then start the server (default is http://localhost:8000):

```
python manage.py runserver
```

Now you can browse the [API](http://localhost:8000/api/) or start on the [landing page](http://localhost:8000/).

## Task

Create a kubernetes manifest for a pod which will containa ToDo app container:

1. Fork this repository.
1. Use `kind` to spin up a cluster from a `cluster.yml` configuration file.
1. Run bootstrap.sh to deploy the app to the cluster and to install ingress controller.
1. Create a `ingress.yml` file for `Ingress` to manage ingress traffic.
1. `Ingress` requirement:
   1. `Ingress` file should be located in `./infrastructure/ingress` directory
   2. `Ingress` should have 1 http rule
   3. `Ingress` should have 1 path based rule
   4. Rule should route traffic to the app on `/` path
   5. Rule should capture path and forward it to the app. `path: {your_regex}`
1. After ingress deployment you should be able to access the app on `http://localhost` and see the app running.
1. There should not be any requests failing with 404 status code in browser console.
1. `README.md` should have instructuions on how to validate the changes
1. Create PR with your changes and attach it for validation on a platform.

# How to validate the changes

1. Run Bootstrap Script

```bash
./bootstrap.sh
```

2. Verify Deployment

```bash
kubectl get all -n todoapp
kubectl get all -n mysql
```

3. Check Ingress resource:

```bash
kubectl get ingress -n todoapp
```

4. Validation
   To validate the changes, follow these steps:
   1. Access the application via http://localhost.
   1. Check for successful page load without any 404 errors in the browser console.
   1. Verify that the path is being captured and forwarded to the application as expected.
