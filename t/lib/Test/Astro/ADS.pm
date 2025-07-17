package Test::Astro::ADS;

my $mocked_dev_key = 'A_very_long_string_to_use_as_a_dev_key';

# can't mock the _build_token method, so set the env variable
$ENV{ADS_DEV_KEY} = $mocked_dev_key;

1;
