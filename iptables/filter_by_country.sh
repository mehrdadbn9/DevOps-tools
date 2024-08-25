#!/bin/bash

# Block incoming NEW packets originating from Iran, Iraq, and Oman
iptables -A INPUT -m geoip --src-cc IR,IQ,OM -m state --state NEW -j DROP

# Allow any outgoing traffic including traffic to Iran, Iraq, and Oman
iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
