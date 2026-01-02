Create configuration file for ethernet port named eth0

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

If this didn't help reboot.