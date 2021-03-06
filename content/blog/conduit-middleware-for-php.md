+++
title = "conduit middleware for php"
date = "2015-01-21"
slug = "2015/01/21/conduit-middleware-for-php"
Categories = []
+++

Long back, I happened to talk with [Beau Simensen](https://beau.io/) about [stackphp](http://stackphp.com/) on #auraphp channel. It was hard for me to digest when I noticed it need `symfony/http-kernel` and its dependencies.

After a few months, I started to like the middleware approach of slim framework and wanted to push it to aura. But nothing happened  there.

## Conduit to rescue

Conduit is a Middleware for PHP built by [Matthew Weier O'Phinney](http://mwop.net/) lead of Zend framework. Conduit supports the current [PSR-7 proposal](https://github.com/php-fig/fig-standards/blob/master/proposed/http-message.md). I believe like the many PSR's, PSR-7 will be a revolution in the PHP world. Conduit is really a micro framework and can grow with your project.

## Starting your project

I hope you know about the tool [composer](https://getcomposer.org) and know about PHP 5.3 to follow the tutorial.

```
mkdir sample-project
cd sample-project
composer require "phly/conduit:0.10.*"
mkdir web
```

We have created an extra `web` folder, so it acts as the document root. Create an `index.php` file in the `web` folder and lets start serving our first `Hello conduit!` message.

```php
<?php
require dirname(__DIR__) . '/vendor/autoload.php';

use Phly\Conduit\Middleware;
use Phly\Http\Server;

$app = new Middleware();
$app->pipe('/', function ($request, $response, $next) {
    return $response->write('Hello conduit!')->end();
});
$server = Server::createServer($app,
  $_SERVER,
  $_GET,
  $_POST,
  $_COOKIE,
  $_FILES
);
$server->listen();
```

Start your web server, or fire your built in PHP server.

```bash
php -S localhost:8000 web/index.php -t web
```

Point your browser to `http://localhost:8000` and you can see `Hello conduit!`.

## Middlewares

Conduit route is very limited and will not handle dynamic routing. So we need a router middleware to resuce. Let us build our first router middleware. If you check the [docs](https://github.com/phly/conduit/blob/0.10.0/README.md#creating-middleware) middleware can be a closure, invokable objects, array callback etc. We will stick with `closure` in the examples.

The idea is same even if you are using a different library.

1. Get the path via `$request->getUri()->getPath()`
2. Check router if the path is matching
3. If
    * `no` call the next middleware in stack. ie `return $next()`
    * `yes` execute the controller and return back the response

> Be sure that if you change something you need to return the response. Because Request and Response are immutable.

In-order to build something like the above, we need a [router library](https://github.com/auraphp/Aura.Router) which can handle routing, and a [dispatcher library](https://github.com/auraphp/Aura.Dispatcher) which can handle the necessary operation when a route is found.

Install the dependencies.

```bash
composer require "aura/router:~2.0" "aura/dispatcher:~2.0"
```

The router middleware will look like as below.

```php
<?php
$router = new \Aura\Router\Router(
    new \Aura\Router\RouteCollection(new \Aura\Router\RouteFactory),
    new \Aura\Router\Generator
);
$dispatcher = new \Aura\Dispatcher\Dispatcher(array(), 'controller', 'action');

$app->pipe(function ($request, $response, $next) use ($router, $dispatcher) {
    $path = $request->getUri()->getPath();
    $route = $router->match($path, $request->getServerParams());
    if (! $route) {
        return $next();
    }
    $params = $route->params;
    $params['request'] = $request;
    $params['response'] = $response;
    $result = $dispatcher->__invoke($params);
    if ($result instanceof \Psr\Http\Message\ResponseInterface) {
        $response = $result;
    } else {
        $response = $response->write($result)->end();
    }
    return $response;
});
```

Now your router middleware can handle dynamic things. You can see the full example over   [gist](https://gist.github.com/harikt/477902c09eb51dad6433).

You may need an authentication middleware to check whether the user is authenticated, or a content negotiation middleware to set the corresponding `Content-Type` header in the response.

I have created a [skelton project](https://github.com/harikt/conduit-skelton) which have a [router middleware](https://github.com/harikt/conduit-skelton/blob/0.2.0/src/Conduit/Middleware/RouterMiddleware.php), [authentication middleware](https://github.com/harikt/conduit-skelton/blob/0.2.0/src/Conduit/Middleware/AuthenticationMiddleware.php) and [negotiation middleware](https://github.com/harikt/conduit-skelton/blob/0.2.0/src/Conduit/Middleware/NegotiationMiddleware.php) with the help of a few libraries. Less libraray means less code to maintain, easy to understand and debug the code behind the scenes.

Today, I noticed one question over reddit `Moving to a real framework.. need help with the migration` wrote my [suggestion](http://www.reddit.com/r/PHP/comments/2t4970/moving_to_a_real_framework_need_help_with_the/cnvml5m) how conduit + aura can help.

Play and enjoy!
