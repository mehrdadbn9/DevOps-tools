[] need update
\# command and explanation:
kubectl create -f etcd-operator-crd.yaml

kubectl create -f etcd-operator-sa.yaml

kubectl get serviceaccounts

kubectl create -f etcd-operator-role.yaml

kubectl create -f etcd-cluster-cr.yaml

kubectl describe etcdcluster/example-etcd-cluster

kubectl get services --selector etcd_cluster=example-etcd-cluster

kubectl describe etcdcluster/example-etcd-cluster

kubectl run --rm -i --tty etcdctl --image quay.io/coreos/etcd \
--restart=Never -- /bin/sh
inside:
$ etcdctl --endpoints http://example-etcd-cluster-client:2379 cluster-health

kubectl patch etcdcluster example-etcd-cluster --type='json' \
-p '[{"op": "replace", "path": "/spec/version", "value":3.3.12}]'

