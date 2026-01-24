# Caddy
The Caddy service can be used to handle traffic to the server and self sign a ssl-certificate for a homelab / internal server.

Alternatively to this service Caddy can also just be installed on the target system.

## Service Definition
```yaml
caddy:
    image: caddy:latest
    container_name: caddy
    restart: unless-stopped
    volumes:
        - ./Caddyfile:/etc/caddy/Caddyfile
    ports:
        - "3001:3001"
    networks:
        - my_network
```

The network attribute is needed, so that the Caddy service can route traffic to the other containers.

## Volumes
**./Caddyfile**

The configuration file for the Caddy service.
For more information see [caddyserver.com](https://caddyserver.com/docs/caddyfile-tutorial).

## Usage Information
It would be best to only have a single Caddy service for the whole target system.

## Certificate
By adding the following volume, the root certificate from the Caddy service can be found.
```yml
- ./caddy_data:/data
```

The path to the root certificate is as follows.
Please note that root privileges are needed to interact with this volume.
```bash
caddy_data/caddy/pki/authorities/local/root.crt
```

## Caddyfile Examples
### Reverse Proxy
```
{
    local_certs
}

test.pi {
    reverse_proxy test-service:4000
}
```

### File Server
```
:3001 {
    root * /srv/sites
    file_server
}
```
This would need the service to have a volume mounted to a directory for /srv/sites to enable adding / removing files from the file server.

## Networks
Caddy should be used with an external docker network, so it can reroute the traffic to every docker container on the system.