package Test::AllTests;

use warnings;
use strict;
use Test::Unit::TestSuite;
use Test::CopyDBTest;
use Test::Debconf::DbDriver::DirTreeTest;
use Test::Debconf::DbDriver::FileTest;
use Test::Debconf::DbDriver::PackageDirTest;

sub suite {
	my $class = shift;

	# create an empty suite
	my $suite = Test::Unit::TestSuite->empty_new("All Tests Suite");

	# add CopyDB test suite
	$suite->add_test(Test::CopyDBTest->suite());

	# add DirTree test suite
	$suite->add_test(Test::Debconf::DbDriver::DirTreeTest->suite());

	# add File test suite
	$suite->add_test(Test::Debconf::DbDriver::FileTest->suite());

	# add PackageDir test suite
	$suite->add_test(Test::Debconf::DbDriver::PackageDirTest->suite());

	my $skip_ldap = defined($ENV{TEST_DEBCONF_SKIP_LDAP})
		&& $ENV{TEST_DEBCONF_SKIP_LDAP} eq '1';
	if (!$skip_ldap) {
		# add LDAP test suite
		my $ldapsuite;
		my $loaded = eval {
			require Test::Debconf::DbDriver::LDAPTest;
			$ldapsuite = Test::Debconf::DbDriver::LDAPTest->suite();
			1;
		};
		$suite->add_test($ldapsuite)
			if $loaded && $ldapsuite;
	}

	# add your test suite or test case
	# extract suite by way of suite method and add
	#$suite->add_test(MyModule::Suite->suite());

	# get and add another existing suite
	#$suite->add_test(Test::Unit::TestSuite->new("MyModule::TestCase"));


	# return the suite built
	return $suite;
}

1;
