---
layout: post
title: "Cakephp ORM and logging queries"
date: 2016-01-16 00:03:25 +0530
comments: true
categories: [cakephp, orm, logging, psr-3, psr-7, debugbar]
---

Working with [cakephp/orm](http://packagist.org/packages/cakephp/orm) library, I needed to log all the queries.
Cakephp provides a way to do it via [cakephp/log](http://packagist.org/packages/cakephp/log).

```php
use Cake\Log\Log;

Log::config('queries', [
	'className' => 'File',
	'path' => '/my/log/path/',
	'file' => 'app',
	'scopes' => ['queriesLog']
]);
```

But you are not limited, if you need to configure it to a PSR-3 logger like [monolog/monolog](http://packagist.org/packages/monolog/monolog)

```php
use Cake\Log\Log;
use Monolog\Logger;
use Monolog\Handler\StreamHandler;

Log::config('default', function () {
    $log = new Logger('cli');
    $log->pushHandler(new StreamHandler('php://stdout'));
    return $log;
});
```

That was pretty simple and it logs to cli.

Thank you [José Lorenzo Rodríguez](https://github.com/lorenzo) for providing the necessary information.

How about logging the queries to a debugbar?

Install [fabfuel/prophiler](https://github.com/fabfuel/prophiler/)

```json
composer require fabfuel/prophiler
```

## Configuring debugbar

```php
use Cake\Log\Log;
use Fabfuel\Prophiler\Profiler;
use Fabfuel\Prophiler\Toolbar;
use Fabfuel\Prophiler\DataCollector\Request;
use Fabfuel\Prophiler\Adapter\Psr\Log\Logger;

$profiler = new Profiler();
$toolbar = new Toolbar($profiler);
// add your data collectors
// $toolbar->addDataCollector(new Request());

Log::config('db', function () use ($profiler) {
	$log = new Logger($profiler);
	return $log;
});
```

Using a PSR-7 framework like zend-expressive,  [bitExpert/prophiler-psr7-middleware](https://github.com/bitExpert/prophiler-psr7-middleware) is your friend.
