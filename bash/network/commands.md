nmcli connection add con-name static ifname ens39 type
ethernet ipv4.address 192.168.2.2/24 ipv4.gateway
192.168.2.254 ipv4.dns 8.8.8.8,8.8.4.4
nmcli connection reload
systemctl restart NetworkManager

nmcli connection delete static
nmcli connection add con-name dynamic ifname ens39 type
ethernet
nmcli connection reload
systemctl restart NetworkManager