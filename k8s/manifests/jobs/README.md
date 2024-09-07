## make it suspende or clean up pod
kubectl patch jobs/counter --type=strategic --patch '{"spec":{"suspend":true}}'

To resume the job, simply flip the suspend flag:
$ kubectl patch jobs/counter --type=strategic \
--patch '{"spec":{"suspend":false}}'

