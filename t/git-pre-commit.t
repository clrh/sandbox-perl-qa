#!/usr/bin/perl

use Modern::Perl;
use Test::Strict;

my @cmd = `git diff-index --name-only --cached HEAD`;
foreach (@cmd) {
  chomp ($_);
  syntax_ok ($_);
}
