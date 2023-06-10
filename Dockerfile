# Copyright (C) 2018 Sebastian Pipping <sebastian@pipping.org>
# Licensed under the MIT license

FROM debian:bookworm-slim

RUN apt-get update && apt-get install --no-install-recommends --yes -V \
        jekyll \
        lighttpd

RUN jekyll -v

# Render website
WORKDIR /root/site
COPY _includes/ _includes/
COPY _layouts/ _layouts/
COPY _posts/ _posts/
COPY css/ css/
COPY dokumentation/ dokumentation/
COPY downloads/ downloads/
COPY img/ img/
COPY kontakt/ kontakt/
COPY support/ support/
COPY _config.yml index.html ./
RUN jekyll build --destination /var/www/html --trace

# Activate access log
# https://github.com/moby/moby/issues/6880#issuecomment-344114520
RUN ln -s ../conf-available/10-accesslog.conf /etc/lighttpd/conf-enabled/
RUN mkfifo -m 600 /var/log/lighttpd/access.log
RUN chown www-data:www-data /var/log/lighttpd/access.log
EXPOSE 80
CMD ["sh", "-c", "cat <> /var/log/lighttpd/access.log & lighttpd -D -f /etc/lighttpd/lighttpd.conf"]

# Apply system upgrades last
# .. to not be turned into a no-op by Docker cache most of the time
RUN apt-get update && apt-get --yes dist-upgrade
