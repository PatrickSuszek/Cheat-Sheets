# Local Certificates
To enable ssl for local services the root certificate of the local proxy needs to be added to the system.
When downloading the certificate from the server, it needs to have the correct permission.

View permissions:
```bash
ls -l file.crt
```

Change permission:
```bash
sudo chown user:user file.crt
```

## Testing
To test execute curl on the site.
If it works curl will show the html code of the site.
Else it will show this message:

```
curl: (60) SSL certificate OpenSSL verify result: unable to get local issuer certificate (20)
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the webpage mentioned above.
```

## Garuda Linux (Arch Based)
To add a certificate it needs to be copied to the certificate folder.
Afterwards the certificate handler needs to be updated.

```bash
sudo cp file.crt /etc/ca-certificates/trust-source/anchors/file.crt
sudo trust extract-compat
```

To remove the certificate remove the file from the store and execute the trust command again.

## Firefox
Firefox doesn't use the systems trusted certificates, so it needs to be added manually under the follwoing settings path:

```
Settings -> Privacy & Security ->  Security -> View Certificates -> Authorities (default tab) -> Import
```