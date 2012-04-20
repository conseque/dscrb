#!/bin/bash

r -n 15 sadd '!C' 'blkid | sort' 'cut -d\" \" -f3 .ssh/authorized_keys | xargs' 'date' 'hostname' 'mount' 'uname -a' 'uptime'
r -n 15 sadd '!E' 'grep LogLevel /etc/ssh/sshd_config' 'uname -a' 'vim-cmd hostsvc/net/info'
r -n 15 sadd '!F' 'uname -a' 'vim-cmd hostsvc/net/info' 'vim-cmd hostsvc/net/query_networkhint'
r -n 15 sadd '!H' '/opt/fcms/bin/fcmsutil /dev/fclp0' '/opt/fcms/bin/fcmsutil /dev/fclp1' 'bdf' 'ioscan -funC disk' 'lanscan' 'netstat -nrv' 'scsimgr -p get_attr all_lun -a device_file -a wwid -a state' 'vgdisplay -v'
r -n 15 sadd '!O' 'grep LogLevel /etc/ssh/sshd_config' 'hostid' 'uname -a' 'zfs list -r -s used depo1/auxbackup'
r -n 15 sadd '!R' 'arch' 'df -PH' 'fdisk -l' 'grep LogLevel /etc/ssh/sshd_config' 'grep ^ /sys/class/fc_host/host*/port_name' 'ip -o a' 'ip -o r' 'iptables-save' 'lsmod' 'lspci' 'lvs' 'multipath -ll' 'postqueue -p' 'pvs' 'sfdisk -d' 'vgs'
r -n 15 sadd '!S' 'df -PH' 'dnsdomainname' 'fdisk -l' 'ip -o a' 'ip -o r' 'uname -a'
r -n 15 sadd '!U' 'apt-get -s upgrade | grep newly' 'arch' 'df -PH' 'fdisk -l' 'grep LogLevel /etc/ssh/sshd_config' 'ip -o a' 'ip -o r' 'iptables-save' 'lsmod' 'lspci' 'lvs' 'pvs' 'sfdisk -d' 'vgs'
r -n 15 sadd '!c' '.ssh/authorized_keys' '/etc/exports' '/etc/fstab' '/etc/ntp.conf' '/etc/resolv.conf'
r -n 15 sadd '!e' '/proc/cpuinfo' '/proc/loadavg' '/proc/meminfo' '/proc/partitions' '/proc/swaps'
r -n 15 sadd '!f' '/proc/cpuinfo' '/proc/loadavg' '/proc/meminfo' '/proc/partitions' '/proc/swaps'
r -n 15 sadd '!r' '/etc/audit/audit.rules' '/etc/audit/auditd.conf' '/etc/sysconfig/network' '/proc/cpuinfo' '/proc/loadavg' '/proc/meminfo' '/proc/net/vlan/config' '/proc/partitions' '/proc/swaps'
r -n 15 sadd '!s' '/etc/HOSTNAME' '/proc/cpuinfo' '/proc/loadavg' '/proc/meminfo' '/proc/partitions' '/proc/swaps'
r -n 15 sadd '!u' '/etc/hostname' '/etc/network/interfaces' '/proc/cpuinfo' '/proc/loadavg' '/proc/meminfo' '/proc/net/vlan/config' '/proc/partitions' '/proc/swaps'
# can be dumped w/
# #!/usr/bin/perl
# use Redis::hiredis;     my $r = Redis::hiredis->new(host=>"i",port=>6380);         $r->select(15);
# for $set (sort @{$r->keys("!*")}) { $jion = join "' '", sort @{$r->smembers($set)}; print "r sadd '$set' '$jion'\n"; }
#

