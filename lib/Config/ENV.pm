package Config::ENV;

use strict;
use warnings;

our $VERSION = '0.01';

sub import {
	my $class   = shift;
	my $package = caller(0);
	my $name    = shift;

	{
		no strict 'refs';
		push @{"$package\::ISA"}, __PACKAGE__;

		for my $method (qw/common config parent/) {
			*{"$package\::$method"} = \&{__PACKAGE__ . "::" . $method}
		}

		no warnings 'once';
		${"$package\::data"} = +{
			common => {},
			envs => {},
			name => $name,
		};
	};
}

sub _data {
	my $package = shift || caller(1);
	no strict 'refs';
	${"$package\::data"};
}

sub common ($) {
	my ($hash) = @_;
	_data->{common} = $hash;
}

sub config ($$) {
	my ($name, $hash) = @_;
	_data->{envs}->{$name} = $hash;
}

sub param {
	my ($package, $name, $hash) = @_;
	my $data = _data($package);

	my $vals = $data->{_merged}->{$package->env} ||= +{
		%{ $data->{common} },
		%{ $data->{envs}->{$package->env} || {} }
	};

	$vals->{$name};
}

sub parent ($) {
	my ($name) = @_;
	%{ _data->{envs}->{$name} || {} };
}

sub env {
	my ($package) = @_;
	$ENV{_data($package)->{name}} || 'default';
}

1;
__END__

=encoding utf8

=head1 NAME

Config::ENV - Various configs determined by %ENV

=head1 SYNOPSIS

  use Config::ENV 'PLACK_ENV'; # use $ENV{PLACK_ENV} to determine configs



=head1 DESCRIPTION

Config::ENV is 

=head1 AUTHOR

cho45 E<lt>cho45@lowreal.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
