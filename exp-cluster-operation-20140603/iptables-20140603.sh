#! /bin/bash
service iptables save
service iptables stop
chkconfig iptables off
service iptables status

