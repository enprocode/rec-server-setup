FROM docker.io/mirakc/mirakc:debian
RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl wget jq socat git unzip \
    cmake g++ gcc make build-essential autoconf automake pkg-config libpcsclite-dev pcscd pcsc-tools libccid \
    && git clone https://github.com/Junch25/rec-cmd-install.git ~/rec-cmd-install \
    && /bin/bash ~/rec-cmd-install/shell/recpt1-install.sh \
    && wget https://raw.githubusercontent.com/Junch25/mirack-epgstation-px-x1ud/main/docker/mirakc/mirakc_init.sh \
    && cp mirakc_init.sh /usr/local/bin/mirakc_init.sh \
    && chmod 775 /usr/local/bin/mirakc_init.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/tmp/* \
    && rm -rf /tmp/*
EXPOSE 40772
ENV MIRAKC_CONFIG=/etc/mirakc/config.yml
VOLUME ["/var/lib/mirakc/epg"]
ENTRYPOINT ["/usr/local/bin/mirakc_init.sh"]