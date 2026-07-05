FROM docker.io/mirakc/mirakc:debian
RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl wget jq socat git unzip \
    cmake g++ gcc make build-essential autoconf automake pkg-config libpcsclite-dev pcscd pcsc-tools libccid \
    # recpt1 と B25 デコードライブラリ libaribb25 を上流からビルド (Docker は root なので sudo は使わない)
    && git clone https://github.com/tsukumijima/libaribb25.git /tmp/libaribb25 \
    && cd /tmp/libaribb25 && cmake . && make && make install \
    && git clone https://github.com/stz2012/recpt1.git /tmp/recpt1 \
    && cd /tmp/recpt1/recpt1 && ./autogen.sh && ./configure --enable-b25 && make && make install \
    && cd / \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/tmp/* \
    && rm -rf /tmp/*
# 本リポジトリの mirakc 起動スクリプトをそのまま利用する (ビルドコンテキスト = docker/docker)
COPY mirakc/mirakc_init.sh /usr/local/bin/mirakc_init.sh
RUN chmod 775 /usr/local/bin/mirakc_init.sh
EXPOSE 40772
ENV MIRAKC_CONFIG=/etc/mirakc/config.yml
VOLUME ["/var/lib/mirakc/epg"]
ENTRYPOINT ["/usr/local/bin/mirakc_init.sh"]