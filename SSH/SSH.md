# 1 Key per Service
With a .ssh/config file different keys can be used for different services.

```bash
Host *
IdentitiesOnly yes

Host github.com
HostName github.com
User git
IdentityFile ~/.ssh/github
```

## Notes
- The referenced identity file is the private key
- If a host has multiple services add the "Port X" parameter, where X is the port of the service
  - 22 is the standard ssh port