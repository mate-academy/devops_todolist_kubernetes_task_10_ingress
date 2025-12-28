

kubectl edit deployment ingress-nginx-controller -n ingress-nginx

add to spec.template.spec

      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet


or 

kubectl patch deployment ingress-nginx-controller \
-n ingress-nginx \
--type='merge' \
-p '{
  "spec": {
    "template": {
      "spec": {
        "hostNetwork": true,
        "dnsPolicy": "ClusterFirstWithHostNet"
      }
    }
  }
}'

kubectl apply -f .infrastructure/ingress/ingress.yml

wait for ingress pods to redeploy.

access site via http://localhost/