#!/usr/bin/perl
use Redis::hiredis;     my $r = Redis::hiredis->new(host=>"i",port=>6379);         $r->select(15);
for $set (sort @{$r->keys("!*")}) { $jion = join "' '", sort @{$r->smembers($set)}; print "r sadd '$set' '$jion'\n"; }

