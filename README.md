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

to validate changes you can access `http://localhost`
to see pods you launched run `kubectl get pods -n todoapp` `kubectl get pods -n ingress-nginx` `kubectl get pods -n mysql`
to see clusters run `kubectl config get-contexts` (current context will be marked with a star)

cleanup:
`kubectl delete ns todoapp`
`kubectl delete ns mysql`
`kubectl delete ns ingress-nginx`
`kubectl config use-context docker-desktop`
`kubectl config delete-context kind-kind`
`kind delete cluster`
