#!/bin/bash

# Set the hard limit of open file descriptors really high.
# Tor will also potentially run out of ports.
ulimit -SHn 65000

# Set the txqueuelen high, to prevent premature drops
# maybe 20000 it's too much
#ifconfig eth0 txqueuelen 5000

# Load an amalgam of gigabit-tuning sysctls from:
# https://github.com/torservers/server-config-templates/blob/master/sysctl.conf
# http://datatag.web.cern.ch/datatag/howto/tcp.html
# http://fasterdata.es.net/TCP-tuning/linux.html
# http://www.acc.umu.se/~maswan/linux-netperf.txt
# http://www.psc.edu/networking/projects/tcptune/#Linux
# and elsewhere...
# We have no idea which of these are needed yet for our actual use
# case, but they do help (especially the nf-contrack ones):
sysctl -p << EOF
net.core.rmem_max = 33554432
net.core.wmem_max = 33554432
net.ipv4.tcp_rmem = 4096 87380 33554432
net.ipv4.tcp_wmem = 4096 65536 33554432
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.tcp_moderate_rcvbuf = 1
net.ipv4.tcp_max_syn_backlog = 10240
net.ipv4.tcp_fin_timeout = 30
vm.min_free_kbytes = 65536
net.ipv4.netfilter.ip_conntrack_max = 196608
net.netfilter.nf_conntrack_tcp_timeout_established = 7200
net.netfilter.nf_conntrack_checksum = 0
net.netfilter.nf_conntrack_max = 196608
net.netfilter.nf_conntrack_tcp_timeout_syn_sent = 15
net.nf_conntrack_max = 196608
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.ip_local_port_range = 1025 65530
net.core.somaxconn = 20480
net.ipv4.tcp_timestamps = 0
EOF

#net.core.netdev_max_backlog = 2500
#net.ipv4.tcp_tw_recycle = 1
#net.ipv4.tcp_max_orphans = 8192
#net.ipv4.tcp_max_tw_buckets = 2000000
#net.ipv4.tcp_keepalive_intvl = 10
