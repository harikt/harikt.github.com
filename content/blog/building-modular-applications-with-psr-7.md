+++
title = "building modular applications with psr 7"
date = "2017-03-24"
slug = "2017/03/24/building-modular-applications-with-psr-7"
Categories = []
+++

[PSR-7, the HTTP message interfaces](http://www.php-fig.org/psr/psr-7/) opened
a new door of creating modular applications.

Sadly many of the PSR-7 implementations added many helper methods.

So if someone is creating a library that needs a PSR-7 implementations they tie
the particular library with the PSR-7 implementation and use these convinient helper methods.

So was [PSR-15: interfaces for HTTP Middleware](https://github.com/http-interop/http-middleware)
and [PSR-17: interfaces for HTTP Factories](https://github.com/http-interop/http-factory)
was proposed.

When creating a module one of the most challenging part is how to serve the
javascript, css and images. We are going to use
[hkt/psr7-asset](github.com/harikt/psr7-asset) which is a fork of
[Aura.Asset_Bundle](https://github.com/friendsofaura/Aura.Asset_Bundle/) .
What you want to do is only map the path to the assets folder.

We can discuss more on the features later and start writing our first module.
The source code of the module is hosted at [github](https://github.com/harikt/psr7-asset-example).

```bash
mkdir -p {src/{Middleware},templates,public/{css,images,js}}
```

The command will create folder structure as below.

> If you are not using *nix probably you want to create each folder separately.


```bash
├── public
│   ├── css
│   ├── images
│   └── js
├── src
│   └── Middleware
└── templates
```

Lets create our `Welcome` middleware.

```php
<?php
namespace Hkt\Psr7AssetExample\Middleware;

use Interop\Http\Factory\ResponseFactoryInterface;
use Interop\Http\ServerMiddleware\MiddlewareInterface;
use Interop\Http\ServerMiddleware\DelegateInterface;
use Psr\Http\Message\ServerRequestInterface;
use Zend\Expressive\Template\TemplateRendererInterface;

class Welcome implements MiddlewareInterface
{
    private $template;

    private $responseFactory;

    public function __construct(
        TemplateRendererInterface $template,
        ResponseFactoryInterface $responseFactory
    ) {
        $this->template = $template;
        $this->responseFactory = $responseFactory;
    }

    public function process(
        ServerRequestInterface $request,
        DelegateInterface $delegate
    ) {
        $response = $this->responseFactory->createResponse();
        $response = $response->withHeader('Content-Type', 'text/html');
        $response->getBody()->write(
            $this->template->render('hkt-psr7-asset-example::welcome', [])
        );
        return $response;
    }
}
```

You can see we have not tied the `Welcome` class to any PSR-7 implementation.
But instead to many interfaces. This helps us to use `Welcome` middleware with any PSR-7 based frameworks.

## How can we serve the static files?

This can be solved with [zf-asset-manager](https://github.com/zfcampus/zf-asset-manager).
What it does is copy the assets to the public folder and the files are served by  webserver.

But what about if you need to alter the behaviour of the file?

Eg : You want to override the `hello.js` contents with something like

```js
$(function () {
    alert("Hello World");
});
```

This is possible with the `hkt/psr7-asset`.

What you need is get the asset locator and set the path to `vendor/package` as

```php
$assetLocator = $di->get('Hkt\Psr7Asset\AssetLocator');
$assetLocator->set('hkt/psr7-asset-example', dirname(dirname(__DIR__)) . '/public');
```

alternatievely you can set individual paths or files also.

```php
$assetLocator = $di->get('Hkt\Psr7Asset\AssetLocator');
$assetLocator->set('vendor/package/images/someimage.png', '/path/to/different-image.png');
```

The full source code of the example module is at [https://github.com/harikt/psr7-asset-example](https://github.com/harikt/psr7-asset-example)


## How can we make use of this module in your application?

Any frameworks that supports psr-7, psr-15 and psr-17 interfaces should work. We will use zend expressive with [Aura.Di](https://github.com/auraphp/Aura.Di) as dependency injection container and [Aura.Router](https://github.com/auraphp/Aura.Router).

```
composer create-project zendframework/zend-expressive-skeleton expressive
```

Below is selection process

```bash
Installing zendframework/zend-expressive-skeleton (2.0.1)
  - Installing zendframework/zend-expressive-skeleton (2.0.1) Loading from cache
Created project in expressive
> ExpressiveInstaller\OptionalPackages::install
Setting up optional packages
Setup data and cache dir
Removing installer development dependencies

  What type of installation would you like?
  [1] Minimal (no default middleware, templates, or assets; configuration only)
  [2] Flat (flat source code structure; default selection)
  [3] Modular (modular source code structure; recommended)
  Make your selection (2): 3
  - Adding package zendframework/zend-expressive-tooling (^0.3.2)
  - Copying src/App/src/ConfigProvider.php

  Which container do you want to use for dependency injection?
  [1] Aura.Di
  [2] Pimple
  [3] Zend ServiceManager
  Make your selection or type a composer package name and version (Zend ServiceManager): 1
  - Adding package aura/di (^3.2)
  - Copying config/container.php
  - Copying config/ExpressiveAuraConfig.php
  - Copying config/ExpressiveAuraDelegatorFactory.php

  Which router do you want to use?
  [1] Aura.Router
  [2] FastRoute
  [3] Zend Router
  Make your selection or type a composer package name and version (FastRoute): 1
  - Adding package zendframework/zend-expressive-aurarouter (^2.0)
  - Copying config/routes.php
  - Copying config/autoload/router.global.php

  Which template engine do you want to use?
  [1] Plates
  [2] Twig
  [3] Zend View installs Zend ServiceManager
  [n] None of the above
  Make your selection or type a composer package name and version (n): 2
  - Adding package zendframework/zend-expressive-twigrenderer (^1.4)
  - Copying config/autoload/templates.global.php
  - Copying src/App/templates/error/404.html.twig
  - Copying src/App/templates/error/error.html.twig
  - Copying src/App/templates/layout/default.html.twig
  - Copying src/App/templates/app/home-page.html.twig

  Which error handler do you want to use during development?
  [1] Whoops
  [n] None of the above
  Make your selection or type a composer package name and version (Whoops): 1
  - Adding package filp/whoops (^2.1.7)
  - Copying config/autoload/development.local.php.dist
```

Once the installation is finished we can start integrating the module.

```
cd expressive
```

Add to your `composer.json` the below configuration.

```json
    "repositories": [
        {
            "type": "git",
            "url": "https://github.com/harikt/psr7-asset-example"
        }
    ],
    "require": {
        "http-interop/http-factory-diactoros": "^0.2.0",
        "hkt/psr7-asset-example":"1.*@dev",
        "hkt/psr7-asset":"1.*@dev",
        ...
    },
```

> I think the dependencies are self explanatory. In case you need any help feel free to comment on the post.

We need a few things for the assets to be displayed.

1. Add the asset router. So that any request coming to `/asset/*` can be served by `Hkt\Psr7Asset\AssetAction`.
2. Configure the `Interop\Http\Factory\ResponseFactoryInterface` to return an instance of `Http\Factory\Diactoros\ResponseFactory`.
3. Add a route to serve the example welcome action 'Hkt\Psr7AssetExample\Middleware\Welcome'

Below is what we can do with Aura.Di configuration.

```php
<?php
// src/App/src/Config/Common.php
namespace App\Config;

use Aura\Di\Container;
use Aura\Di\ContainerConfigInterface;
use Zend\Expressive\Router\Route;

class Common implements ContainerConfigInterface
{
    public function define(Container $di)
    {
        $di->set('Interop\Http\Factory\ResponseFactoryInterface', $di->lazyNew('Http\Factory\Diactoros\ResponseFactory'));
    }

    public function modify(Container $di)
    {
        $router = $di->get('Zend\Expressive\Router\RouterInterface');

        // PSR-7 asset Router

        $route = new Route('/asset/{vendor}/{package}/{file}', 'Hkt\Psr7Asset\AssetAction', ['GET'], 'hkt/psr7-asset');
        $route->setOptions([
            'tokens' => [
                'file' => '(.*)'
            ]
        ]);
        $router->addRoute($route);
        $router->addRoute(new Route('/', 'Hkt\Psr7AssetExample\Middleware\Welcome', ['GET'], 'hkt/psr7-asset-example:welcome'));
        // Try modifying the below lines
        // $assetLocator = $di->get('Hkt\Psr7Asset\AssetLocator');
        // $rootPath = dirname(dirname(dirname(dirname(__DIR__))));
        // $assetLocator->set('hkt/psr7-asset-example/images/white-image.png', $rootPath . '/public/zf-logo.png');
    }
}
```

Now we can load the Aura.Di configuration in `config/container.php` .

```php
<?php
.... more code.

return $builder->newConfiguredInstance([
    new ExpressiveAuraConfig(is_array($config) ? $config : []),
    Hkt\Psr7Asset\Container\AssetConfig::class,
    Hkt\Psr7AssetExample\Container\Common::class,
    App\Config\Common::class,
]);
```

What it does, is load different configurations of different modules.

If you run

```bash
php -S 0.0.0.0:8080 -t public public/index.php
```

and point to `http://localhost:8080` you can see the welcome screen of example module.

Try modifying the `hkt/psr7-asset-example/images/white-image.png` path to a different image and browse  http://localhost:8080/asset/hkt/psr7-asset-example/images/white-image.png

It will render that image.

All source code is accompanied at [https://github.com/harikt/psr7-asset-example-zendexpressive](https://github.com/harikt/psr7-asset-example-zendexpressive)


## Caching

We can use psr7-asset-cache to cache all public files in production.

Hope this will be helpful to someone to begin writing modular applications.
