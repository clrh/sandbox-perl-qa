#!/usr/bin/perl

use Modern::Perl;
use Test::More;
use Test::MockModule;

use My::Module;
use Another::Module;

plan 'no_plan';

{
  my $module = new Test::MockModule('My::Module');
  $module->mock('MySub', sub {'>>>MySub Mocked'});
  is('>>>MySub Mocked', My::Module::MySub, 'Simple Mock');
}

{
  my $module = new Test::MockModule('My::Module');
  $module->mock('MySub', sub {'>>>MySub Mocked'});
  is('>>>MySub Mocked', My::Module::MyGlobalSub, 'Internal Mock');
}

{
  my $module = new Test::MockModule('Another::Module');
  $module->mock('AnotherSub', sub {'>>>AnotherSub Mocked'});
  is('>>>AnotherSub Mocked', My::Module::AnotherSub, 'External Mock');
}

is('>>>MySub', My::Module::MySub, 'Simple Mock');
is('>>>MySub', My::Module::MyGlobalSub, 'No Mock');
is('>>>AnotherSub', Another::Module::AnotherSub, 'External Mock');

