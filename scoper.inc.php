<?php

declare(strict_types=1);

use Isolated\Symfony\Component\Finder\Finder;

return [
    'whitelist' => [
        'PhpSpec\\*',

        // Below only needed to let internal specs run
        'spec\\*',
        'Foo\\*',
        'Bar\\*',
        'Baz\\*',
        'Boz\\*',
        'Biz\\*',
        'Acme\\*',
        'App\\*'
    ],
    'finders' => [
        Finder::create()->files()->in('src'),
        Finder::create()->files()->in('spec'),
        Finder::create()
            ->files()
            ->ignoreVCS(true)
            ->notName('/LICENSE|.*\\.md|.*\\.dist|Makefile|composer\\.json|composer\\.lock/')
            ->exclude([
                'doc',
                'test',
                'test_old',
                'tests',
                'Tests',
                'vendor-bin',
            ])
        ->in('vendor'),
        Finder::create()->append([
            'bin/phpspec',
            'composer.json',
            'box.json',
            'LICENSE'
        ])
    ]
];
