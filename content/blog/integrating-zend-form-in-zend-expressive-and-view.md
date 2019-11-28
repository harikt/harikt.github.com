+++
title = "integrating zend form in zend expressive and view"
date = "2015-11-13"
slug = "2015/11/13/integrating-zend-form-in-zend-expressive-and-view"
Categories = []
+++

Example is based using [Aura.Di](https://github.com/auraphp/Aura.Di).
But the functionality will be same for any containers.
First register the service `Zend\View\HelperPluginManager`, so that we
can access the same object.

To register the form helpers, create the object of `Zend\Form\View\HelperConfig`
and pass the `Zend\View\HelperPluginManager` service.

Example code with [Aura.Di](https://github.com/auraphp/Aura.Di) version 3 configuration.


```php
<?php
use Aura\Di\ContainerConfig;
use Aura\Di\Container;
use Zend\Form\View\HelperConfig;

class ViewHelper extends ContainerConfig
{
    public function define(Container $di)
    {
        $di->set('Zend\View\HelperPluginManager', $di->lazyNew('Zend\View\HelperPluginManager'));
    }

    public function modify(Container $di)
    {
        $serviceManager = $di->get('Zend\View\HelperPluginManager');
        $helper = new HelperConfig();
        $helper->configureServiceManager($servicemanager);
    }
}
```

## Creating your own zend-view helper

1. Create your helper class

```php
<?php
namespace App\View\Helper;

use Zend\View\Helper\AbstractHelper;

class HasError extends AbstractHelper
{
    // add as many parameters you want to pass from the view
    public function __invoke()
    {
        // some code
    }
}
```

2. Registering your helper class.

First get the `Zend\View\HelperPluginManager` service.

2.a ) Registering as a factory

```php
$serviceManager->setFactory('hasError', function () {
    return new \App\View\Helper\HasError();
});
```

2.b ) As an invokable

```php
$serviceManager->setInvokableClass('hasError', 'App\View\Helper\HasError');
```

Now you can access inside zend-view as `$this->hasError()`. If your view
helper need dependencies don't use the `setInvokableClass` method.
Use factory and get the object from the container.

```php
$serviceManager->setFactory('hasError', function () use ($di) {
     return $di->get('App\View\Helper\HasError');
});
```

I wished if `$serviceManager` can understand the aura's `lazyNew` functionality
so that we don't need to register it as a service.

Eg : Below will not work.

```php
$serviceManager->setFactory('hasError', $di->lazyNew('App\View\Helper\HasError'));
```

This is what I love to see it working for this a closure, but with namespaced.
