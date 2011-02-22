#!/usr/bin/perl

use Test::More;
use Modern::Perl;
use My::Module;

plan 'no_plan';

my $got = My::Module::SimpleMathAdd (1,1);
my $expected = 2;
is ($got, $expected, 'GG, + works!');
