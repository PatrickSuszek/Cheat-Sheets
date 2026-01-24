# dnsmasq
The dnsmasq service is a dns server.
This service should be used together with a reverse proxy like [Cyaddy](caddy.md)

## Service Definition
```yaml
dnsmasq:
    image: joweisberg/dnsmasq
    container_name: dnsmasq
    ports:
        - "53:53/udp"
    volumes:
        - ./dnsmasq.conf:/etc/dnsmasq.conf:ro
    networks:
        - proxy
```

The network attribute is needed, so that the reverse proxy service can route traffic to the other containers.

## Volumes
**./dnsmasq.conf**

Configuration file for the dns services.

## Example configuration
```
domain=pi
address=/pi/192.168.1.2
server=192.168.1.1
```

| Attribute | Meaning |
| -- | -- |
| domain | The domain to be resolved. Typically, the hostname of the machine. |
| address | To which ip address every address containing the defined server name should be resolved. |
| server | Upstream server. Handel's everything that can't be resolved locally. |