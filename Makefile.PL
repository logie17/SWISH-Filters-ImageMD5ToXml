use inc::Module::Install;

name     'SWISH-Filters-ImageToMD5Xml';
all_from 'lib/SWISH/Filters/ImageToMD5Xml.pm';
author   q{Logan Bell <loganbell@gmail.com>};
license  'perl';

requires 'SWISH::Filters'                   => 0;
requires 'Search::OpenSearch::Engine::Lucy' => 0.06;
requires 'Mime::Base64'                     => 0;
requires 'Digest::MD5'                      => 0;
build_requires 'Test::More';

auto_install;

WriteAll;

