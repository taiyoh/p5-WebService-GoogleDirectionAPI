use inc::Module::Install;
name 'WebService-GoogleDirectionAPI';
all_from 'lib/WebService/GoogleDirectionAPI.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
