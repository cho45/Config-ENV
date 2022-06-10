package MyConfig;
use warnings;
use strict;

use Config::ENV 'FOO_ENV';

$ENV{FOO_ENV} = 'development';

config default => +{};
config development => +{};
config test => +{};

use Test::More;
use Test::Name::FromLine;

my $sorted_env_names = [ sort @{ __PACKAGE__->env_names } ];
is_deeply $sorted_env_names, [qw/development test/];

done_testing;
