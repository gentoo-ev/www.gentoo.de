[![Build](https://github.com/gentoo-ev/www.gentoo.de/actions/workflows/build.yml/badge.svg)](https://github.com/gentoo-ev/www.gentoo.de/actions/workflows/build.yml)


# How to Build and Run (on Gentoo)

```console
# sudo emerge app-emulation/docker app-emulation/docker-compose
# sudo /etc/init.d/docker start
# docker network create --internal ssl-reverse-proxy
# docker-compose up -d --build
# chromium http://127.0.0.1:50280/ &
```

Enjoy :)
