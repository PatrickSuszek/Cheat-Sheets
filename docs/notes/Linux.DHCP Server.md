---
id: i6o4b6ijiaytvl248dwgc6w
title: DHCP Server
desc: ''
updated: 1760871601136
created: 1760871360948
---

Create configuration file for ethernet port 0
```bash
sudo nano /etc/NetworkManager/system-connections/eth0-dhcp-server.nmconnection
```

Add the following configuration information to the config file
```bash
[connection]
id=eth0-dhcp-server
type=ethernet
interface-name=eth0
autoconnect=true

[ipv4]
method=shared

[ipv6]
method=ignore
```

Restart the network manager
```bash
sudo systemctl restart NetworkManager
```

Check if everything worked
```bash
ifconfig && nmcli c
```
The IP of eth0 should now be 10.42.0.1

If this isn't the case execute:
```bash
sudo chmod 600 /etc/NetworkManager/system-connections/eth0-dhcp-server.nmconnection
```