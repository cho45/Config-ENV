package MyConfig;

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

use Test::More;

is __PACKAGE__->env, 'default';
is __PACKAGE__->param('name'), 'foobar';
ok !__PACKAGE__->param('dsn_user');

$ENV{FOO_ENV} = 'development';

is __PACKAGE__->param('dsn_user'), 'dbi:mysql:dbname=user;host=localhost';

$ENV{FOO_ENV} = 'production';

is __PACKAGE__->param('dsn_user'), 'dbi:mysql:dbname=user;host=127.0.0.254';

done_testing;
