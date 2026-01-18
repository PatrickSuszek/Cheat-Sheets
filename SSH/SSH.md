# 1 Key per Service
With a .ssh/config file different keys can be used for different services.

```bash
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/github
```

## Notes
- The referenced identity file is the private key

## Multiple Services on one Host
If multiple services run on a host the following configuration can be used, so that different keys and ssh ports can be used.

```bash
Host pi
    HostName pi
    Port 22
    User pi
    IdentityFile ~/.ssh/pi

Host forgejo
    HostName pi
    Port 222
    User git
    IdentityFile ~/.ssh/pi_forgejo
```

This example was created from my configuration with a [Forgejo instance using docker compose](../docker/compose/forgejo/).
The Forgejo created ssh git clone links like this:
```
ssh://git@forgejo/***/***.git
```