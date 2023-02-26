# Copyright (C) 2018 Sebastian Pipping <sebastian@pipping.org>
# Licensed under the MIT license

FROM debian:bullseye-slim

RUN apt-get update && apt-get --yes dist-upgrade

RUN apt-get update && apt-get install --no-install-recommends --yes -V \
        build-essential \
        gatling \
        ruby-full

RUN gem install jekyll
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
RUN ln -s /var/www/default _site
RUN jekyll build

# Serve website
# -F        no FTP
# -S        no Samba
# -d        enable directory listings
# -c <DIR>  change into and serve directory <DIR>
EXPOSE 80
CMD ["gatling", "-F", "-S", "-d", "-c", "/var/www/default"]
