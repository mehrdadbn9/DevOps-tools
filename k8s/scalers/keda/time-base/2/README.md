kubectl apply   --force-conflicts  --server-side -f https://github.com/kedacore/keda/releases/download/v2.12.0/keda-2.12.0.yaml

note:
--force-conflicts: Forces the server-side apply process to overwrite any existing conflicts.
--server-side: Uses server-side apply to apply the configuration declaratively, ensuring the server manages conflicts between different clients.

kubectl get pods -n keda
