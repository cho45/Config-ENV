package MyConfig;

use Config::ENV 'FOO_ENV';

common +{
	test => 'test',
};

package Foo;

use Test::More;

BEGIN { MyConfig->import };

is_deeply [ @Foo::ISA ], [];

done_testing;
