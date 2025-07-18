# https://metacpan.org/pod/distribution/Module-CPANfile/lib/cpanfile.pod

requires 'perl' => '5.004';

requires 'Data::Dumper::Concise';
requires 'Feature::Compat::Try';
requires 'Mojolicious';
requires 'Mojo::File';
requires 'Mojo::URL';
requires 'Mojo::Util';
requires 'Moo';
requires 'Moo::Role';
requires 'PerlX::Maybe';
requires 'strictures';
requires 'Types::Standard';

on test => sub {
    requires 'Test2::V0' => '0.000139'; # isa checks

    requires 'Mojo::UserAgent::Mockable';
    requires 'Test2::Tools::Compare'    => '1.302196'; # number_gt available Apr 2023
};

on 'develop' => sub {
  requires 'perl' => '5.026'; # postfix deref, hash slices, Test2, indented here-docs

  requires 'Dist::Zilla';
  requires 'FindBin';
  requires 'Mojo::File';

  recommends 'Dist::Zilla::PluginBundle::Git';
  recommends 'Dist::Zilla::Plugin::GithubMeta';
  recommends 'Dist::Zilla::Plugin::NextRelease';

  # these were missing when I tried to dzil test
  recommends 'Dist::Zilla::Plugin::MetaProvides::Package';
  recommends 'Dist::Zilla::Plugin::RPM';
  recommends 'Dist::Zilla::Plugin::Repository';
};
