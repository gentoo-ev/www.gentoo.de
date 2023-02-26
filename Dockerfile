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
COPY .  /root/site/
RUN ln -s /var/www/default /root/site/_site
WORKDIR /root/site
RUN jekyll build

# Serve website
# -F        no FTP
# -S        no Samba
# -d        enable directory listings
# -c <DIR>  change into and serve directory <DIR>
EXPOSE 80
CMD ["gatling", "-F", "-S", "-d", "-c", "/var/www/default"]
