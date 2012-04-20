#!/usr/bin/perl

use Switch; my $ssh='SSH_AUTH_SOCK=/tmp/ssh-zhNBuE6383/agent.6383 ssh -o ConnectTimeout=2 root@';	# ssh auth
use Redis::hiredis; my $r = Redis::hiredis->new(host=>"i",port=>6380);					# redis connection
$r->select(5); my $hsto = @{$r->zrange(":IP:",-1,-1)}[0]; $r->select(15); my $OUT;			# host to connect
use IPC::Open2;	local (*O,*I); my $pid=open2(*O,*I,"${ssh}${hsto}");					# ssh connection
&ask ("cat /etc/issue"); $r->set("$hsto:issue", $OUT); switch ($OUT) {	case /ubuntu/i	{ &ubun() }	# U for ubuntu
									case /red hat/i	{ &redh() }	# R for rhel
									case /hp rel/i  { &hpux() }	# H for hpux
									case /esxi/i    { &esxi() }	# E for esxi
									case /suse/i	{ &sles() }	# S for sles
									case /solar/i	{ &sola() }	# O for solaris
									else		{ &othr() } }	# F for other stuff
			push @cmnds, @{$r->smembers("!C")};	push @files, @{$r->smembers("!c")};	# C for common unix
			for (@cmnds) { &ask("$_");	s/ //g;		$r->set("$hsto:!$_", $OUT); }	# execute @cmnds
			for (@files) { &ask("cat $_");	s/.*\///g;	$r->set("$hsto:$_", $OUT); }	# read all @files
			print I "exit\n";				1 while (<O>);			# exit ssh
#####################################################################################################KEEPWATCH!
sub ask() { $OUT=''; print I "$_[0]\necho ===\n"; while (($l=<O>) !~ m/===/) { $OUT .= $l }; $OUT=~s/\n$//g; }
###############################################################################################################
sub ubun() {			&ask("ls /proc/net/bonding/bond*");			push @files, (split "\n", $OUT);
		$r->set("$hsto:cast", "U");	push @cmnds, @{$r->smembers("!U")};	push @files, @{$r->smembers("!u")}; }
###############################################################################################################
sub redh() {			&ask("ls /proc/net/bonding/bond*");			push @files, (split "\n", $OUT);
				&ask("ls /etc/sysconfig/network-scripts/ifcfg-*");	push @files, (split "\n", $OUT);
				&ask("ls /etc/sysconfig/network-scripts/route-*");	push @files, (split "\n", $OUT);
		$r->set("$hsto:cast", "R");	push @cmnds, @{$r->smembers("!R")};	push @files, @{$r->smembers("!r")}; }
###############################################################################################################
sub hpux() {	$r->set("$hsto:cast", "H");	push @cmnds, @{$r->smembers("!H")};	push @files, @{$r->smembers("!h")}; }
###############################################################################################################
sub esxi() {	$r->set("$hsto:cast", "E");	push @cmnds, @{$r->smembers("!E")};	push @files, @{$r->smembers("!e")}; }
###############################################################################################################
sub sles() {			&ask("ls /proc/net/bonding/bond*");			push @files, (split "\n", $OUT);
				&ask("ls /etc/sysconfig/network-scripts/ifcfg-*");	push @files, (split "\n", $OUT);
				&ask("ls /etc/sysconfig/network-scripts/ifroute-*");	push @files, (split "\n", $OUT);
		$r->set("$hsto:cast", "S");	push @cmnds, @{$r->smembers("!S")};	push @files, @{$r->smembers("!s")}; }
###############################################################################################################
sub sola() {	$r->set("$hsto:cast", "O");	push @cmnds, @{$r->smembers("!O")};	push @files, @{$r->smembers("!o")}; }
###############################################################################################################
sub othr() {	$r->set("$hsto:cast", "F");	push @cmnds, @{$r->smembers("!F")};	push @files, @{$r->smembers("!f")}; }
###############################################################################################################

