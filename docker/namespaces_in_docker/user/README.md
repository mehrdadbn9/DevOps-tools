user remap of deamon docker:

```bash
{
  "userns-remap": "default"
}


or we can use docker below option:
{
  "userns-remap": "testuser"
}

echo "testuser:100000:65536" | sudo tee -a /etc/subuid
echo "testuser:100000:65536" | sudo tee -a /etc/subgid

sudo systemctl restart docker

for airflow user on main  host we can check:

cat /proc/<container_pid>/uid_map
-->         0       100000        65536


grep dockremap /etc/subuid

dockremap:231072:65536

grep dockremap /etc/subgid

dockremap:231072:65536
```
refrence: https://docs.docker.com/engine/security/userns-remap/

To disable user namespaces for a specific container, add the --userns=host flag
