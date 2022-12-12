#!/bin/perl

use warnings;
use strict;
use DB_File;
use IO::Prompter;
use Crypt::Password qw(password check_password);

my $filename = "account.db";
tie my %db, "DB_File", $filename
    or die "Cannot open file $filename: $!\n";

# ask for password
my $user = prompt 'Login: ';
my $pass = prompt 'Password: ', -echo=>"";

if( exists $db{$user} ) {
    # check correct login
    if(check_password($db{$user}, $pass)) {
        printf "Welcome %s !\n", $user;
    } else {
        printf "Wrong password\n";
    }
} else {
    # set login/password in the db
    $db{$user} = password($pass, undef);
    printf "%s: added with success !\n", $user;
}
