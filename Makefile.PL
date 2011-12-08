use inc::Module::Install;
name 'WebService-GoogleDirectionAPI';
all_from 'lib/WebService/GoogleDirectionAPI.pm';

requires 'URI';
requires 'JSON';
requires 'Furl';
requires 'Class::Accessor::Lite';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
