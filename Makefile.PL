BEGIN {
	use inc::Module::Install;

	my @mip = qw(
		Module::Install::AuthorTests
		Module::Install::Repository
		Module::Install::ReadmeFromPod
	);
	for (@mip) {
		eval "require $_";
		if ($@) {
			eval "require inc::$_";
			if ($@) {
				warn $@;
				printf("# Install following (perl Makefile.PL | cpanm):\n%s", join("\n", @mip));
				exit 1;
			}
		}
	}
};

name 'Config-ENV';
all_from 'lib/Config/ENV.pm';

requires 'Exporter::Lite';

test_requires 'Test::More';
test_requires 'Test::Fatal';
test_requires 'Test::Name::FromLine';

# Module::Install::AuthorTests
author_tests('xt');

# Module::Install::Repository
auto_set_repository;

# Module::Install::ReadmeFromPod
readme_from 'lib/Config/ENV.pm';

auto_include;
WriteAll;
