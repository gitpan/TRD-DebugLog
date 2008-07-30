use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'TRD::DebugLog',
    license             => 'perl',
    dist_author         => 'Takuya Ichikawa <trd.ichi@gmail.com>',
    dist_version_from   => 'lib/TRD/DebugLog.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'TRD-DebugLog-*' ],
);

$builder->create_build_script();
