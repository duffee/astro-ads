use Test::Most;
use Test::Strict;

use FindBin '$Bin';
use Module::Util;

BEGIN {

    my @modules = Module::Util::find_in_namespace( '', "$Bin/../lib" );

    foreach my $module ( sort @modules ) {
        use_ok($module);
    }
}

#syntax_ok('bin/app.pl');

done_testing();

1;
