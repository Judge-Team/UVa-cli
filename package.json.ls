name: \UVa-cli

version: \0.0.0

description: 'CLI for UVa online judge'

homepage: \https://github.com/Judge-Team/UVa-cli

bugs:
    url: \https://github.com/Judge-Team/UVa-cli/issues

licenses:
    license: \MIT

contributors:
    *   name: 'ChangZhuo Chen (陳昌倬)'
        email: \czchen@gmail.com
        url: \http://czchen.info
    ...

bin:
    *   uva: \./bin/uva
        'uva-add': \./bin/uva-add

repository:
    *   type: \git
        url: \https://github.com/Judge-Team/UVa-cli

dependencies:
    commander: \~2.3.0
    mkdirp: \~0.5.0
    'js-yaml': \~3.1.0
    pkginfo: \~0.3.0
    winston: \~0.7.3

devDependencies:
    chai: \~1.9.1
    LiveScript: \~1.2.0
    mocha: \~1.21.4

scripts:
    prepublish: 'node_modules/.bin/lsc -c *.ls src'
    test: 'node_modules/.bin/mocha'

engines:
    node: \~0.10.30
