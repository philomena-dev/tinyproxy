# Tinyproxy Docker Image

...because there's no official one.

Builds tinyproxy for transparent proxying. Expects port 3128 to be used.

See `tinyproxy.conf` for a sample config.

## Running

```
docker run --rm -it -v ./tinyproxy.conf:/tinyproxy.conf -p 3128:3128 ghcr.io/philomena-dev/tinyproxy
```

## Configuring

See `tinyproxy.conf`. Make sure to edit the `Allow` line with your server IP like so:

```
User root
Group root
Port 3128
LogLevel Error
DisableViaHeader yes
ConnectPort 443
ConnectPort 8443
Allow 1.2.3.4
Allow 2001:dead:beef::1
MaxClients 32
Anonymous "Host"
Anonymous "Authorization"
Anonymous "Cookie"
Anonymous "User-Agent"
Anonymous "Content-Type"
Anonymous "Accept-Encoding"
Anonymous "Range"
Anonymous "Cache-Control"
Anonymous "Content-Length"
Anonymous "Accept-Charset"
```

You may also use subnets like so:

```
Allow 10.0.0.0/24
```

## License

This Dockerfile is published under the MIT license. See LICENSE for more information.
