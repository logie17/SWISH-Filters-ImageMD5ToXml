use inc::Module::Install;

name     'SWISH-Filters-ImageToMD5Xml';
all_from 'lib/SWISH/Filters/ImageToMD5Xml.pm';
author   q{Logan Bell <loganbell@gmail.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

