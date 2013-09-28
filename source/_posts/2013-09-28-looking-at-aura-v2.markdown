---
layout: post
title: "Looking at aura version 2"
date: 2013-09-28 06:53
comments: true
categories: [auraphp, php]
---

If you have noticed recently, there have been tons of commits from 
[Paul M Jones](https://github.com/pmjones)﻿ for aura version 2. 

More standalone repos born. Everyone should try and give feedback as much as possible.

Interesting stuffs split from Aura.Sql v 1.3 are 

[Extended PDO](https://github.com/auraphp/Aura.Sql/tree/develop-2),

As the name says, it is an extended version of PDO. Good thing is it is 
PHP 5.3 compatible. 

If you have worked with PDO you know the good and bad.
One of the difficulty is, it cannot use an array for an in clause.

```php
<?php
// the array to be quoted
$array = array('foo', 'bar', 'baz');

// the statement to prepare
$stm = 'SELECT * FROM test WHERE foo IN (:foo) AND bar = :bar'

// the native PDO way does not work (PHP Notice:  Array to string conversion)
$pdo = new Pdo(...);
$sth = $pdo->prepare($stm);
$sth->bindValue('foo', $array);
```

ExtendedPDO helps you to do it. 

```php
<?php
$pdo = new ExtendedPdo(...);
$stm = 'SELECT * FROM test WHERE foo IN (:foo)';
$pdo->bindValues(array(
    'foo' => array('foo', 'bar', 'baz'),
    'bar' => 'qux',
));
$sth = $pdo->prepare($stm);
echo $sth->queryString;
```

Try out an example, and see in action.

Your composer.json will look as 

```json
{
    "minimum-stability": "dev",
    "require": {
        "aura/sql":"dev-develop-2"
    }
}
```

Run the below Sql query in your favourite tools like phpmyadmin or adminer.

```sql
-- Adminer 3.7.1 MySQL dump

SET NAMES utf8;
SET foreign_key_checks = 0;
SET time_zone = '+05:30';
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `polls_choice`;
CREATE TABLE `polls_choice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poll_id` int(11) NOT NULL,
  `choice_text` varchar(200) NOT NULL,
  `votes` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `polls_choice` (`id`, `poll_id`, `choice_text`, `votes`) VALUES
(1,	1,	'Not much',	0),
(2,	1,	'The sky',	0),
(5,	1,	'Hello World',	0);

-- 2013-09-28 11:22:17
```

Run the below PHP code and see the result.

```php
<?php
require __DIR__ . '/vendor/autoload.php';

use Aura\Sql\ExtendedPdo;
use Aura\Sql\Profiler;

$pdo = new ExtendedPdo(
    'mysql:host=localhost;dbname=dbname',
    'user',
    'password',
    array(), // driver options as key-value pairs
    array()  // attributes as key-value pairs
);
$pdo->setProfiler(new Profiler);
$pdo->getProfiler()->setActive(true);

$stm = 'SELECT * FROM polls_choice WHERE id IN (:id) AND poll_id = :poll_id';

$bind = array(
    'id' => array('1', '2'),
    'poll_id' => '1',
);
$results = $pdo->fetchAll($stm, $bind);

foreach ($results as $result) {
  echo "Query Result : " . $result['choice_text'] . PHP_EOL;
}

echo "Profiler" . PHP_EOL;

$profiles = $pdo->getProfiler()->getProfiles();

foreach ($profiles as $profile) {
  echo ' Function : ' . $profile['function'] . PHP_EOL;
  echo ' Duration : ' . $profile['duration'] . PHP_EOL;
  echo ' Statement : ' . $profile['statement'] . PHP_EOL;
  echo ' Bind Values : ' . print_r($profile['bind_values'], true) . PHP_EOL;
}
```

It comes with lazy connection, profiler, connection locator etc. Read more from 
[getting started docs](https://github.com/auraphp/Aura.Sql/tree/develop-2#getting-started)


##[Aura.Sql_Schema](https://github.com/auraphp/Aura.Sql_Schema) 

An independent schema discovery tool for MySQL, PostgreSQL, 
SQLite, and Microsoft SQL Server. You can 
[read more from the docs](https://github.com/auraphp/Aura.Sql_Schema#getting-started)

##[Aura.Sql_Query](https://github.com/auraphp/Aura.Sql_Query)

Independent query builders for MySQL, PostgreSQL, SQLite, and Microsoft SQL Server

Good thing is all are standalone.

Version 2 also comes with a new 
[Dispatcher](https://github.com/auraphp/Aura.Dispatcher) 
and [Includer](https://github.com/auraphp/Aura.Includer).

You can read the story behind Dispatcher from 
[here](https://groups.google.com/d/msg/auraphp/hyjEPEeo6_w/u616Pu3kQrcJ) 
and Includer from 
[here](https://groups.google.com/d/msg/auraphp/WOo6TSceqHU/ZdgIkUgU0VIJ)

vi [Includer](https://github.com/auraphp/Aura.Includer) 
aura solved one of the problem of reading configuration files.

Let us look into the example of the Aura.Includer and how it works.

The `composer.json` looks like the one below.

```json
{
    "minimum-stability": "dev",
    "require": {
        "aura/cli": "dev-develop-2",
        "aura/web": "dev-develop-2",
        "aura/autoload": "dev-develop-2",
        "aura/dispatcher": "dev-develop-2",
        "aura/html": "dev-master",
        "aura/input": "dev-master",
        "aura/view": "2.*",
        "aura/includer": "dev-develop-2",
        "aura/router": "dev-develop",
        "aura/di": "1.*"
    }
}
```

We can use the includer to read the configuration files and store it and
later use the cached file. The `includer.php` looks like 

```php
<?php
$loader = require __DIR__ . '/vendor/autoload.php';
 
$includer = new \Aura\Includer\Includer();
 
$includer->setDirs(array(
    __DIR__ . '/vendor/aura/router',
    __DIR__ . '/vendor/aura/dispatcher',
    __DIR__ . '/vendor/aura/web',
    __DIR__ . '/vendor/aura/view',
    __DIR__ . '/vendor/aura/html',
    __DIR__ . '/vendor/aura/cli',
    __DIR__ . '/vendor/aura/input',
));
 
$includer->setFiles(array(
    'config/default.php',
));
 
use Aura\Router\Map;
use Aura\Router\DefinitionFactory;
use Aura\Router\RouteFactory;
 
$router = new Map(new DefinitionFactory, new RouteFactory);
 
use Aura\Di\Container;
use Aura\Di\Forge;
use Aura\Di\Config;
 
$di = new Container(new Forge(new Config));
 
$includer->setVars(array(
    'loader' => $loader,
    'router' => $router,
    'di' => $di,
));
 
if (! file_exists(__DIR__ . '/cache/includer.php')) {
    $includer->load();
    $text = $includer->read();
    file_put_contents(__DIR__ . '/cache/includer.php', '<?php' . PHP_EOL . $text);
} else {
    $includer->setCacheFile(__DIR__ . '/cache/includer.php');
    $includer->load();
}
$stdio = $di->newInstance('Aura\Cli\Stdio');
$stdio->outln('This is normal text.');
```

Install the dependencies via `composer` and run via cli `php includer.php`.

The Aura.Includer is a nice addition for version 2 
( I am also seeing it can be used in version 1 ) 
which will help a lot in the making of the framework with the libraries.

If you are interested to use, learn, or have a feedback a warm welcome to 
[join the google group for aura project for PHP](https://groups.google.com/forum/#!forum/auraphp)

Have a nice day ahead. Enjoy PHPing.
