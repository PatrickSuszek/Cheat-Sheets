# Windows
## 11
All commands are run PowerShell.

### Connection Name
```bash
Get-DnsClientServerAddress
```

### Set DNS
This command needs administrator privileges to run.
Using it will manually set the primary and secondary dns server and stop any automatic overwrite.
```bash
Set-DnsClientServerAddress -InterfaceAlias "Wi-Fi" -ServerAddresses x.x.x.x,y.y.y.y
```

### Reset DNS
This command needs administrator privileges to run.
Using it will re-enable the automatic setting of the primary and secondary dns servers.
```bash
Set-DnsClientServerAddress -InterfaceAlias "Wi-Fi" -ResetServerAddresses
```

### Problem Resolving
If it still doesn't work disable ipv6 in the adapters properties.