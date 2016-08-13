#!/bin/bash

# Set the hard limit of open file descriptors really high.
# Tor will also potentially run out of ports.
ulimit -SHn 65000

# Set the txqueuelen high, to prevent premature drops
# maybe 20000 it's too much
#ifconfig eth0 txqueuelen 5000
