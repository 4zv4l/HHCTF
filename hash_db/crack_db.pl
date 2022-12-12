#!/bin/perl

use warnings;
use strict;
use DB_File;
use Getopt::Long;
use IO::Prompter;
use List::MoreUtils qw(all);
use Crypt::Password qw(password check_password);
use Term::ANSIColor qw(:constants);
use feature 'say';

# Parsing Argument
my $usage = "usage: $0 -f [db_file] -w [wordlist] -u [user]\n";
$ARGV[0] || do{print $usage; exit 0};
GetOptions (
    'u=s' => \my $user,
    'w=s' => \my $wordlist,
    'f=s' => \my $dbfile,
) or die $usage;
die $usage if( ! all {defined} $user, $wordlist, $dbfile );

tie my %db, "DB_File", $dbfile, O_RDONLY
    or die "Cannot open file $dbfile: $!\n";

# Brute Force Magic
if( exists $db{$user} ) {
    open my $file, $wordlist
        or die "Cannot open wordlist: $!\n";

    my $found = 0;
    my $pass;
    while((!$found) && defined($pass = <$file>)) {
        chomp $pass;
        warn "Trying $pass\n";
        $found = 1 if(check_password($db{$user}, $pass));
    }

    if($found) {
        say GREEN "Login: $user, Password: $pass", RESET;
    } else {
        say RED "Not Found..", RESET;
    }
} else {
    say RED "$user: is not in the database", RESET;
}
