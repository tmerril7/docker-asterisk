FROM ubuntu:jammy-20230425
WORKDIR /tmp
ARG S6_OVERLAY_VERSION=3.1.5.0
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository universe && apt-get update
RUN apt-get install -y xz-utils git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev uuid-dev libedit-dev
ARG ASTERISK_VERSION=18.18.0
RUN wget --no-check-certificate https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${ASTERISK_VERSION}.tar.gz && tar -xvzf asterisk-${ASTERISK_VERSION}.tar.gz
WORKDIR /tmp/asterisk-${ASTERISK_VERSION}
RUN ./configure && make && make install

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

ADD /etc /etc
RUN chmod 777 -R /etc/services.d
ENTRYPOINT ["/init"]