#!/bin/bash
set -e

# Loop NTP ENV variables modding ntp.conf file
for e in ${!NTP_default*} ; do sed -i "/${!e}/s/^/#/" /etc/ntp.conf ; done
for e in ${!NTP_add_pool*} ; do sed -i "$ a ${!e}" /etc/ntp.conf ; done 
for e in ${!NTP_add_fallback*} ; do sed -i "$ a ${!e}" /etc/ntp.conf ; done
for e in ${!NTP_add_lan*} ; do sed -i "$ a ${!e}" /etc/ntp.conf ; done

service ntp start
rsyslogd -n &
wait
exit 0
