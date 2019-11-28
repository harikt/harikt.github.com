+++
title = "speedup configuration aura v2"
date = "2014-12-06"
slug = "2014/12/06/speedup-configuration-aura-v2"
Categories = []
+++

Aura v2 added auto resolution in-order to help lazy people writing configuration manually. Even though it was introduced to help, [it introduced a few issues](https://github.com/auraphp/Aura.Di/blob/2.1.0/README.md#auto-resolution-of-parameter-values).

So auto resolution will be disabled in the future. Some of the complains/suggestions are how to easily write the di configuration.

So introducing you [FOA.DiConfig](https://github.com/friendsofaura/FOA.DiConfig)

## Installation

```bash
composer require foa/di-config
```

## Usage

```bash
vendor/bin/di-config-dump
Usage : vendor/bin/di-config-dump /real/path/to/file.php
Usage : vendor/bin/di-config-dump /real/path/to/directory
```

## Example 1

Let's assume you have

```php
<?php
// src/Vendor/World.php
namespace Vendor;

class World
{
    public function __construct(Baz $baz)
    {
    }
}
```

```php
<?php
// src/Vendor/Baz.php
namespace Vendor;

class Baz
{
}
```

Now you can make use of

```bash
vendor/bin/di-config-dump src/Vendor/World.php
```

will output

```php
$di->params['Vendor\World']['baz'] = $di->lazyNew('Vendor\Baz');
```

You can also pass directory path instead of file. It will read the files and display the configuration.

## Example 2

Let us look into another example

```php
<?php
// src/Vendor/Hello.php
namespace Vendor;

class Hello
{
    public function __construct(
        \Aura\Web\Response $response,
        \Aura\Web\Request $request,
        \Aura\Router\Router $router,
        World $word
    ) {
    }
}

```

```bash
vendor/bin/di-config-dump src/Vendor/Hello.php
```

will output

```bash
$di->params['Vendor\Hello']['response'] = $di->lazyGet('aura/web-kernel:response');
$di->params['Vendor\Hello']['request'] = $di->lazyGet('aura/web-kernel:request');
$di->params['Vendor\Hello']['router'] = $di->lazyGet('aura/web-kernel:router');
$di->params['Vendor\Hello']['word'] = $di->lazyNew('Vendor\World');
```

If you look carefully the `Aura\Web\Response`, `Aura\Web\Request` and `Aura\Router\Router` are making use of `lazyGet` which gets the shared instance of the [Aura.Web_Kernel](https://github.com/auraphp/Aura.Web_Kernel) .

If you are not using inside the framework just pass something as 2nd argument.


```bash
vendor/bin/di-config-dump src/Vendor/Hello.php h
$di->params['Vendor\Hello']['response'] = $di->lazyNew('Aura\Web\Response');
$di->params['Vendor\Hello']['request'] = $di->lazyNew('Aura\Web\Request');
$di->params['Vendor\Hello']['router'] = $di->lazyNew('Aura\Router\Router');
$di->params['Vendor\Hello']['word'] = $di->lazyNew('Vendor\World');
```

> Please make sure all the files need to be autoloadable in-order to generate this.

If you like to improve something [fork and contribute](https://github.com/friendsofaura/FOA.DiConfig).

I have purposefully left not to make use of [Aura.Cli](https://github.com/auraphp/Aura.Cli) in this library. Not sure if we need to integrate or not.
