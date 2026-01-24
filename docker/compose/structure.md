# Structure off a Compose File

## Service and Resource Defintion
```yaml
services:
networks:
volumes:
```

## Attributes
Ordered making understanding a service definition easier.
For more information see [docs.docker.com](https://docs.docker.com/reference/compose-file/services/).

| Attribute | Usage |
| -- | -- |
| image | The image to be used |
| container_name | The unique name of the container. |
| command | Command to be executed by the container. |
| privileged | Privileged status. |
| restart | When to restart the container. |
| depends_on | List of services this one depends on. |
| ports | Port mapping from the host system to the container. |
| env_file | .env file to be used. |
| environment | Direct definition of environment variables. |
| volumes | List of used volumes and definition of mounting points. |
| networks | List of used docker networks. |
| links | List of network links. |
| extra_hosts | List of hostname resolutions. |