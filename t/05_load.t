package MyConfig;
use strict;
use Test::More;
use Test::Fatal;
use Test::Name::FromLine;

use Config::ENV 'FOO_ENV';

$ENV{FOO_ENV} = 'development';

subtest load => sub {
	config development => { to_be_overridden => 'test', other => 'foobar' };
	load   development => 't/config/hash.pl';

	is __PACKAGE__->param('to_be_overridden'), 'overridden';
	is __PACKAGE__->param('other'), 'foobar';
};

subtest errors => sub {
	like exception { load development => 't/config/error.pl'    }, qr{^Bareword "error" not allowed while "strict subs"};
	like exception { load development => 't/config/non-hash.pl' }, qr{^t/config/non-hash\.pl does not return HashRef};
	like exception { load development => 't/config/undef.pl'    }, qr{t/config/undef\.pl does not return true value};
};

done_testing;
