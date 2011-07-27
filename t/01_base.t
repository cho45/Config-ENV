package MyConfig;
use strict;

use Config::ENV 'FOO_ENV';

common +{
	name => 'foobar',
};

config development => +{
	dsn_user => 'dbi:mysql:dbname=user;host=localhost',
};

config test => +{
	dsn_user => 'dbi:mysql:dbname=user;host=localhost',
};

config production => +{
	dsn_user => 'dbi:mysql:dbname=user;host=127.0.0.254',
};

config production_bot => +{
	parent('production'),
	bot => 1,
};

use Test::More;

undef $ENV{FOO_ENV};

is __PACKAGE__->env, 'default';
is __PACKAGE__->param('name'), 'foobar';
ok !__PACKAGE__->param('dsn_user');

$ENV{FOO_ENV} = 'development';

is __PACKAGE__->param('dsn_user'), 'dbi:mysql:dbname=user;host=localhost';

$ENV{FOO_ENV} = 'production';

is __PACKAGE__->param('dsn_user'), 'dbi:mysql:dbname=user;host=127.0.0.254';

$ENV{FOO_ENV} = 'production_bot';

is __PACKAGE__->param('dsn_user'), 'dbi:mysql:dbname=user;host=127.0.0.254';
is __PACKAGE__->param('bot'), 1;


package Foo;
use strict;

BEGIN { MyConfig->import };

use Test::More;

is config->param('name'), 'foobar', 'shorthand';

done_testing;
