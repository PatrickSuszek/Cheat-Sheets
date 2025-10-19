---
id: 0iphmmevp4lyecb61eslmrg
title: WSL
desc: ''
updated: 1760872976505
created: 1760872914672
---
## Network
To access the same network as the host pc add the following to the ~/.wslconfig file and restart the pc.
```
[wsl2]
networkingMode=mirrored
```