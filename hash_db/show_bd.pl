#!/bin/perl

use strict;
use warnings;
use DB_File;

my $dbfilename = "account.db";

tie my %db, "DB_File", $dbfilename
    or die "Cannot open file 'fruit': $!\n";

printf "%-7s | %-10s\n", "login", "password";
printf "------------------\n";
while (my ($k, $v) = each %db)
  { printf "%-7s | %-10s\n", $k, $v }
