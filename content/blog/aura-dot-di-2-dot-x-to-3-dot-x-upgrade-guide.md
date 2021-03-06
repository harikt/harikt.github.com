+++
title = "aura dot di 2 dot x to 3 dot x upgrade guide"
date = "2016-03-15"
slug = "2016/03/15/aura-dot-di-2-dot-x-to-3-dot-x-upgrade-guide"
Categories = []
+++

3.x has a very minimal BC break. But if you are not sure what are they, then you may feel the pain.
I am trying to document most of them, incase I missed please [edit and send a pull request](https://github.com/harikt/harikt.github.com/edit/source/source/_posts/2016-03-15-aura-dot-di-2-dot-x-to-3-dot-x-upgrade-guide.markdown). 

I will try to eventually pushed to the main Aura.Di repo.

## BC Breaks

### Instantiation

The way di container is instantiated has been changed from

```php
<?php
use Aura\Di\Container;
use Aura\Di\Factory;
use Aura\Di\ContainerBuilder;

$di = new Container(new Factory);

// or 

$container_builder = new ContainerBuilder();
$di = $container_builder->newInstance(
    array(),
    array(),
    $auto_resolve = false
);
```

to 

```php
<?php
use Aura\Di\ContainerBuilder;

$container_builder = new ContainerBuilder();

// use the builder to create and configure a container
// using an array of ContainerConfig classes
$di = $container_builder->newConfiguredInstance([
    'Aura\Cli\_Config\Common',
    'Aura\Router\_Config\Common',
    'Aura\Web\_Config\Common',
]);
```

### setter vs setters

`$di->setter` is now `$di->setters`. Please note there is an additional `s` in the end. [https://github.com/auraphp/Aura.Di/issues/115](https://github.com/auraphp/Aura.Di/issues/115).

### Automatic locking

Automatic locking of container once an object is created by container. So make sure everything is lazy call, else you will run something like [Cannot modify container when locked](https://github.com/auraphp/Aura.Di/issues/118).

### Config vs ContainerConfig

Version 2 [Aura\Di\Config](https://github.com/auraphp/Aura.Di/blob/2.2.4/src/Config.php) is now [Aura\Di\ContainerConfig](https://github.com/auraphp/Aura.Di/blob/3.0.0/src/ContainerConfig.php)

## Features

### lazyGetCall

Example taken from [Radar](https://github.com/radarphp/Radar.Adr/blob/0b4fa74c4939a715562d60e37c1976fc59b420b6/src/Config.php#L50 )

```
$di->params['Radar\Adr\Handler\RoutingHandler']['matcher'] = $di->lazyGetCall('radar/adr:router', 'getMatcher');
```

Here the `matcher` assigned is taken from the [RouterContainer](https://github.com/auraphp/Aura.Router/blob/3.0.0/src/RouterContainer.php#L263-L273) `getMatcher` method.

### Instance Factories

Create multiple instances of the class. You can read the [docs](http://auraphp.com/packages/3.x/Di/factories.html)


