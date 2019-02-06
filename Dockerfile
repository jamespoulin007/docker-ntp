FROM ubuntu:18.04

LABEL Maintainer="James Poulin"

RUN set -e \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -yq \
        ntp \
        less \
        nano \
        rsyslog

ENV \
    NTP_default0="pool 0.ubuntu.pool.ntp.org iburst" \
    NTP_default1="pool 1.ubuntu.pool.ntp.org iburst" \
    NTP_default2="pool 2.ubuntu.pool.ntp.org iburst" \
    NTP_default3="pool 3.ubuntu.pool.ntp.org iburst" \
    NTP_default4="pool ntp.ubuntu.com" \
    NTP_add_poolComment0='################ USER MODS ##################' \
    NTP_add_poolComment1='######################################' \
    NTP_add_poolComment2='# NTP Servers Used for Time Sync' \
    NTP_add_poolComment3='######################################' \
    NTP_add_poolEntry0="pool 0.ca.pool.ntp.org iburst" \
    NTP_add_poolEntry1="pool 1.ca.pool.ntp.org iburst" \
    NTP_add_poolEntry2="pool 2.ca.pool.ntp.org iburst" \
    NTP_add_poolEntry3="pool 3.ca.pool.ntp.org iburst" \
    NTP_add_poolEntry4="pool ca.pool.ntp.org iburst" \
    NTP_add_fallbackComment0='######################################' \
    NTP_add_fallbackComment1='# Local Fallback For No Connectivity' \
    NTP_add_fallbackComment2='######################################' \
    NTP_add_fallbackEntry0="server 127.127.1.0" \
    NTP_add_fallbackEntry1="fudge 127.127.1.0 stratum 10" \
    NTP_add_lanComment0='######################################' \
    NTP_add_lanComment1='# LAN Specified for Client Access' \
    NTP_add_lanComment2='######################################' \
    NTP_add_lanEntry0="restrict 10.0.0.0 mask 255.0.0.0 nomodify notrap"\
    TINI_VERSION=v0.18.0

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

RUN chmod +x /tini

COPY rsyslog.conf /etc/rsyslog.conf

COPY launch.sh /

RUN chmod +x /launch.sh

ENTRYPOINT ["/tini", "--"]

CMD ["/launch.sh"]



