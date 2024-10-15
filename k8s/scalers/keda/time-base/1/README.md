kubectl apply -f https://github.com/kedacore/keda/releases/download/v2.10.0/keda-2.10.0.yaml

kubectl create deployment nginx --image nginx --replicas 1

kubectl apply -f cron.yaml

kubectl get hpa -n default

kubectl get scaledobject time-based-scaler2 -n default
>
```
k get scaledobject -A
NAMESPACE   NAME                SCALETARGETKIND      SCALETARGETNAME   MIN   MAX   TRIGGERS   AUTHENTICATION   READY   ACTIVE   FALLBACK   AGE
default     cron-scaledobject   apps/v1.Deployment   nginx                         cron                        True    True     False      23m

```

kubectl run -it --rm debug --image=busybox --restart=Never -- /bin/sh -c "date -R -u; TZ='Asia/Tehran' date -R"