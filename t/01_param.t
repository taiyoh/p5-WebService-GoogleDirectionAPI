use strict;
use Test::More;

use WebService::GoogleDirectionAPI;

my $gd = WebService::GoogleDirectionAPI->new;

my $from = '35.495016,139.437612';
my $to   = '35.4910884006037,139.452799663226';

do {
    local $@;
    eval { $gd->search };
    ok $@, "require from and to param";
};

do {
    local $@;
    eval { $gd->search($from, $to) };
    ok $@, "require sensor param";
};

do {
    local $@;
    $gd->sensor("foobar");
    eval { $gd->search($from, $to) };
    ok $@, "invalid sensor param";
};

do {
    local $@;
    #require YAML;
    $gd->sensor("false");
    my $res = $gd->search($from, $to);
    ok $res, "response exists";
    #diag YAML::Dump($res);
};


done_testing;
