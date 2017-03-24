---
layout: post
title: "Using cakephp migration as standalone"
date: 2017-03-24 22:32:33 +0530
comments: true
categories: [cakephp, migrations]
published: false
---

Cakephp version 3 have a nice ORM. When using the `cakephp/orm`,
it may be nice to integrate `cakephp/migration` than any other migration
libraries, even though it use phinx under the hood.

Lets see how we can integrate `cakephp/migration` with our application.

From your application

```
composer require cakephp/migrations:dev-master
```

The dev-master is currently passed for we need the latest version of master branch.
Before [this pull request](https://github.com/cakephp/migrations/pull/308), it was
having dependency on `cakephp/cakephp`, which is not needed.

Lets create our migration console script

```php
#!/usr/bin/env php
<?php
// bin/cakephp-phinx

$file = dirname(__DIR__) . '/vendor/autoload.php';
$loader      = null;
if (file_exists($file)) {
    $loader = require $file;
    if (!defined('ROOT')) {
        define('ROOT', dirname(dirname($file)));
    }
    if (!defined('CACHE')) {
        define('CACHE', ROOT . '/tmp/cache/');
    }
    break;
}
if ( ! $loader) {
    throw new RuntimeException('vendor/autoload.php could not be found. Did you run `composer install`?');
}
use Cake\Core\Plugin;
use Cake\Datasource\ConnectionManager;
use Migrations\MigrationsDispatcher;
if (!defined('PHINX_VERSION')) {
    define('PHINX_VERSION', (0 === strpos('@PHINX_VERSION@', '@PHINX_VERSION')) ? '0.6.6' : '@PHINX_VERSION@');
}
$config = require  ROOT . '/config/app.php';
ConnectionManager::config($config['Datasources']);
Cake\Cache\Cache::config($config['Cache']);
$application = new MigrationsDispatcher(PHINX_VERSION);
$application->run();
```

You may notice constants like `ROOT`, `CACHE` etc. It is possible that we can
get rid of constants if needed. Normally I copy portions of  https://github.com/cakephp/app/blob/fa4ff8c9784abec3c306e0210ce79afe11ba21b5/config/app.default.php#L220-L283 and keep in `/config/app.php` file.

Once done, we can run the migration script.
