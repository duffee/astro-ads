#!/usr/bin/perl
#
# finds all recorded tests in the t/ directory and removes any
# Bearer tokens
#
# run on a git commit hook, so that the dev key never gets committed,
# by putting this script into .git/hooks/pre-commit
# https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks
# https://stackoverflow.com/questions/57591839/how-can-i-commit-git-hooks

use v5.20;

use FindBin qw($Bin);
use File::Find;
use Mojo::File;

my $sub = sub { my $name = $File::Find::name; say $name if $name =~ /out$/; };
my $scrub = sub {
    next unless $File::Find::name =~ /mock\.out$/;
    my $path = Mojo::File->new( $File::Find::name );
    my $mock = $path->slurp;

    say 'Scrubbing ', $path->basename
        if $mock =~ s/Bearer \w{10,}/Bearer TOKEN_REMOVED/g;
    $path->spew( $mock )
        or warn "Error writing to $path: $!\n";
};

find $scrub, "$Bin/../t";
exit;
