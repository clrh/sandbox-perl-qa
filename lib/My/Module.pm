package My::Module;

use Modern::Perl;
use Another::Module;

sub MySub {
  '>>>MySub'
}

sub MyGlobalSub {
  My::Module::MySub
}

sub AnotherSub {
  Another::Module::AnotherSub
}

sub SimpleMathAdd {
  my ($a, $b) = @_;
  return $a + $b;
}

1;
