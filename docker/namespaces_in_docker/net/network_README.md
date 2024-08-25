docker use 6 ns
docker use 172.17.0.0
and gateway as docker0 would be 172.17.0.1 that if we do not say anything about subnet and ... would use this interface

```bash
ip netns list --> shows the one that create by commnad not docker
ip netns add dev
ip netsns exec dev bash --> ip a
```

run script to check 

now use ```ip netns exec dev bash``` --> run script

```bash
# Create a new OVS bridge
sudo ovs-vsctl add-br ovs-br0

systemctl start openvswitch-switch.service
sudo ovs-vsctl show

# Create veth pairs
sudo ip link add veth1 type veth peer name veth1-br
sudo ip link add veth2 type veth peer name veth2-br

# Move veth1 to namespace dev
sudo ip link set veth1 netns dev

# Move veth2 to namespace ops
sudo ip link set veth2 netns ops
# Add veth1-br and veth2-br to OVS bridge
sudo ovs-vsctl add-port ovs-br0 veth1-br
sudo ovs-vsctl add-port ovs-br0 veth2-br

# Assign IP to veth1 and bring it up inside dev
sudo ip netns exec dev ip addr add 192.168.1.1/24 dev veth1
sudo ip netns exec dev ip link set dev veth1 up
sudo ip netns exec dev ip link set lo up

# Assign IP to veth2 and bring it up inside ops
sudo ip netns exec ops ip addr add 192.168.1.2/24 dev veth2
sudo ip netns exec ops ip link set dev veth2 up
sudo ip netns exec ops ip link set lo up

# Bring up veth interfaces connected to OVS bridge
sudo ip link set dev veth1-br up
sudo ip link set dev veth2-br up

# Ping from dev to ops
sudo ip netns exec dev ping 192.168.1.2

```





