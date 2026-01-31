# Docker DNS
## Local DNS server
If a local dns server is running on the system, that runs docker containers it can be that the containers can't reach some servers.
For example alpine containers can have problems with reaching the apk archive.

To fix this create this configuration file.
```bash
sudo nano /etc/docker/daemon.json
```

And add the google and cloudeflare dns server ips, so they can be used by the docker daemon.
```json
{
  "dns": ["8.8.8.8", "1.1.1.1"]
}
```