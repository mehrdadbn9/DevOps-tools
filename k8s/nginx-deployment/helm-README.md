helm install ingress-nginx ingress-nginx/ingress-nginx   -f values/ingress-values.yaml

helm install nginx-helm . -f ../values/values.yaml

curl -H "Host: nginx.local" http://172.20.0.2:32642/khodafez

