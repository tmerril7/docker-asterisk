FROM ubuntu:jammy-20250126
WORKDIR /tmp
ARG S6_OVERLAY_VERSION=3.1.5.0
ARG ASTERISK_VERSION=18.18.0
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common && add-apt-repository universe && apt-get update \
&& apt-get install -y --no-install-recommends xz-utils git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libcurl4-openssl-dev libsqlite3-dev build-essential libjansson-dev libxml2-dev uuid-dev libedit-dev \
&& wget --no-check-certificate https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${ASTERISK_VERSION}.tar.gz && tar -xvzf asterisk-${ASTERISK_VERSION}.tar.gz \
&& cd /tmp/asterisk-${ASTERISK_VERSION} \
&& ./configure && make && make install && make samples && cp -r /etc/asterisk/ /tmp/samples/ \
&& apt-get purge -y software-properties-common libnewt-dev libncurses5-dev subversion build-essential uuid-dev \
&& apt-get autoremove -y

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

ADD /etc /etc
RUN chmod 777 -R /etc/services.d
ENTRYPOINT ["/init"]
