use lib '.';
use strict;
use warnings;

use inc::Module::Install;

# Definition.
abstract 'Random generator of message board.';
author 'Michal Josef Spacek <skim@cpan.org>';
author_requires 'English' => 0;
author_requires 'File::Object' => 0;
author_requires 'Test::More' => 0;
author_requires 'Test::NoWarnings' => 0;
author_requires 'Test::Pod' => 0;
author_requires 'Test::Pod::Coverage' => 0;
license 'bsd';
name 'Data-Random-Message-Board';
perl_version 5.008;
readme_from 'Board.pm';
recursive_author_tests('xt');
requires 'Class::Utils' => 0;
requires 'Data::Random::Person' => 0;
requires 'DateTime' => 0;
requires 'Error::Pure' => 0;
requires 'Mo::utils' => 0.08;
requires 'Random::Day::InThePast' => 0;
requires 'Scalar::Util' => 0;
requires 'Text::Lorem' => 0;
resources 'bugtracker' => 'https://github.com/michal-josef-spacek/Data-Random-Message-Board/issues';
resources 'homepage' => 'https://github.com/michal-josef-spacek/Data-Random-Message-Board';
resources 'repository' => 'git://github.com/michal-josef-spacek/Data-Random-Message-Board';
test_requires 'English' => 0;
test_requires 'Error::Pure::Utils' => 0;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();
