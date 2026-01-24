# NetworkManager and DNS
On startup the NetworkManager service will set the dns settings provided by the router as the /etc/resolv.conf.

## Connection Name
The listed commands use "Wired connection 1" as the connection name.
This is the standard wired connection name.
Using this command all connections and their names will be listed.

```bash
nmcli con show
```

## Enabling Static DNS
To disable the auto discovery of the network manager and to define the wanted dns server addresses the following commands can be used.

```bash
nmcli con mod "Wired connection 1" ipv4.dns "x.x.x.x x.x.x.x"
nmcli con mod "Wired connection 1" ipv4.ignore-auto-dns yes
```
The first ip should be the static ip address of the local dns server,
while the second ip should be the routers.

After executing these commands the connection should be refreshed.

## Disabling Static DNS
To enable the auto discovery of the network manager the following commands can be used.

```bash
nmcli con mod "Wired connection 1" ipv4.ignore-auto-dns no
nmcli con mod "Wired connection 1" ipv4.dns ""
```
The command re-enables the auto-detection, while the second clears the static dns settings.

After executing these commands the connection should be refreshed.

## Refreshing Connection
```bash
nmcli con down "Wired connection 1"
nmcli con up "Wired connection 1"
```