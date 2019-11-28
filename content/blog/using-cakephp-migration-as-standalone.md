+++
title = "using cakephp migration as standalone"
date = "2017-03-24"
slug = "2017/03/24/using-cakephp-migration-as-standalone"
Categories = []
+++

Cakephp version 3 have a nice ORM. When using the `cakephp/orm`,
it may be nice to integrate `cakephp/migration` than any other migration
libraries, even though it uses phinx under the hood.

Lets see how we can install and integrate `cakephp/migration` in our application.

```
composer require cakephp/migrations:dev-master
```

> The dev-master is currently passed for we need the latest version of master branch.
Before [this pull request](https://github.com/cakephp/migrations/pull/308), it was
having dependency on `cakephp/cakephp`, which is not needed.

Our migration console script

```php
#!/usr/bin/env php
<?php
use Cake\Cache\Cache;
use Cake\Core\Configure;
use Cake\Core\Configure\Engine\PhpConfig;
use Cake\Datasource\ConnectionManager;
use Migrations\MigrationsDispatcher;

$projectDirectory = dirname(__DIR__);
$file   = $projectDirectory . DIRECTORY_SEPARATOR . 'vendor' . DIRECTORY_SEPARATOR . 'autoload.php';
$loader = null;

if (file_exists($file)) {

    $loader = require $file;

    if (!defined('CACHE')) {
        define('CACHE', $projectDirectory . DIRECTORY_SEPARATOR . 'tmp' . DIRECTORY_SEPARATOR . 'cache' . DIRECTORY_SEPARATOR);
    }
}

if ( ! $loader) {
    throw new RuntimeException('vendor/autoload.php could not be found. Did you run `composer install`?');
}

if (!defined('PHINX_VERSION')) {
    define('PHINX_VERSION', (0 === strpos('@PHINX_VERSION@', '@PHINX_VERSION')) ? '0.6.6' : '@PHINX_VERSION@');
}

try {
    Configure::config('default', new PhpConfig($projectDirectory . DIRECTORY_SEPARATOR . 'config' . DIRECTORY_SEPARATOR) );
    Configure::load('app', 'default', false);
} catch (\Exception $e) {
    exit($e->getMessage() . "\n");
}

Cache::setConfig(Configure::consume('Cache'));
ConnectionManager::setConfig(Configure::consume('Datasources'));
$application = new MigrationsDispatcher(PHINX_VERSION);
$application->run();
```

You may notice the constant `CACHE`. We can get rid of
constants if needed. Normally I copy portions of  [config/app.default.php](https://github.com/cakephp/app/blob/fa4ff8c9784abec3c306e0210ce79afe11ba21b5/config/app.default.php#L220-L283) and keep in `/config/app.php` file which uses some of these constants.

Once done, we can run the migration script as

```bash
bin/cake-phinx
```

> You may probably want to allow necessary permission for the script
to execute. You can do via `chmod +x bin/cake-phinx`

There is another [PR 312](https://github.com/cakephp/migrations/pull/312) waiting for approval. If it is merged you will get all the functionalities of  [https://book.cakephp.org/3.0/en/console-and-shells/orm-cache.html](https://book.cakephp.org/3.0/en/console-and-shells/orm-cache.html)


> PS : If you came across some errors regarding migration plugin not loaded etc.
You may want to add the below code before calling MigrationsDispatcher

```php
Cake\Core\Plugin::load('Migrations', [
    'path' => $projectDirectory . '/vendor/cakephp/migrations/',
]);
```
