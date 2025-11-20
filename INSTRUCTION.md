INSTRUCTION.md
How to validate the Ingress configuration
1. Apply all Kubernetes manifests
kubectl apply -f infrastructure/

2. Verify that the Ingress resource is created
kubectl get ingress
kubectl describe ingress todoapp-ingress


Make sure:

the ingress has regex enabled (use-regex: "true"),

the rewrite-target annotation is present,

the HTTP rule and path-based rule are visible.

3. Check that the NGINX ingress controller picked up the rule
kubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller


There should be no errors related to invalid paths or annotations.

4. Test access via localhost

Open in the browser:

http://localhost/


You should see the ToDo application running.

5. Validate that path capturing works

Run:

curl -I http://localhost/
curl -I http://localhost/foo
curl -I http://localhost/foo/bar


All responses must return 200 OK (no 404 responses).

6. Validate the browser console

Open DevTools → Console.
There must not be any failed requests (no 404 errors).

7. Validate that rewrite works (optional)

Check backend logs:

kubectl logs -l app=todoapp


Your backend should receive the forwarded path correctly (e.g., /foo/bar).