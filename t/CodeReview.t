#!/usr/bin/perl

use Modern::Perl;

use My::Module;
use Another::Module;


#
# Exploring http://blogs.perl.org/users/alexey_shrub/2011/02/non-functional-perl-code-testing---automated-code-review.html
# Help building standard
#

use Test::Strict;

syntax_ok( 'lib/My/Module.pm' );
syntax_ok( 'lib/Another/Module.pm' );

#syntax test
$Test::Strict::TEST_SYNTAX   = 1; 
$Test::Strict::TEST_STRICT   = 0;
$Test::Strict::TEST_WARNINGS = 0; 
all_perl_files_ok ('lib');

#cover test
#all_cover_ok (90,'t/');

#end of lines verification
use Test::EOL;
all_perl_files_ok('lib');

#code bench
#see /usr/bin/countperl
#use Perl::Metrics::Simple;
#my $analyzer = Perl::Metrics::Simple->new;
#my $analysis = $analyzer->analyze_files('lib');
#my $file_count    = $analysis->file_count;
#my $package_count = $analysis->package_count;
#my $sub_count     = $analysis->sub_count;
#my $lines         = $analysis->lines;
#my $main_stats    = $analysis->main_stats;
#my $file_stats    = $analysis->file_stats;
#warn "\n>>> file_count:$file_count \n>>>package_count:$package_count \n>>>sub_count:$sub_count \n>>>lines:$lines \n>>>main_stats:";
#warn Data::Dumper::Dumper($main_stats);
#warn "\n>>> file_stats:";
#warn Data::Dumper::Dumper ($file_stats);


# use Test::Perl::Critic;
# can define .perlcriticrc
# help to give coding best practices
