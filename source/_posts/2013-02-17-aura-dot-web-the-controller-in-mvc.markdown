---
layout: post
title: "Aura.Web:The controller in MVC"
date: 2013-02-17 20:25
comments: true
categories: [auraphp, php]
---

Before introducing [Aura.Web][] let us look at an earlier post 
[Web Routing in PHP with Aura.Router][].

So in Dispatching a Route, we get the controller name and action. The code

```php
$path = parse_url($_SERVER["REQUEST_URI"], PHP_URL_PATH);
$route = $map->match($path, $_SERVER);
if ($route) {
    $controller = $route->values["controller"];
	$action = $route->values["action"];
}
```

Now we know which `class` need to be instantiated and which `method` need to 
be called.

[Aura.Web][] helps you to build the web page controller class, 
which is signal aware and can access the server environment variables 
via the [Context][] class and create a [Response][] transfer object which can 
be passed to [Aura.Http][] or similar ones which can create the exact
`http` response.

In order to create your controller, you need to extend the `Aura\Web\Controller\AbstractPage`

```php
<?php
namespace Vendor\Package\Web;

use Aura\Web\Controller\AbstractPage;

class Page extends AbstractPage
{
    public function actionHello()
    {
        $this->response->setContent('Hello World');
    }
}
```

Now you can create the object of the above `Page` class and pass an 
array of paramters, which include the `action` which need to be executed 
and call the `exec()` method for which it returns a [Response][] transfer object.

```php
<?php
use Vendor\Package\Web\Page;
use Aura\Web\Context;
use Aura\Web\Accept;
use Aura\Web\Response;
use Aura\Web\Signal;
use Aura\Web\Renderer\None as Renderer;

$params = [
    'action' => 'hello',
    'format' => '.html',
];

$page = new Page(
    new Context($GLOBALS),
    new Accept($_SERVER),
    new Response,
    new Signal,
    new Renderer,
    $params
);

$transfer = $page->exec();
```

The action names are named starting with `action`. So even if we pass `hello` as 
the value for the above key `action`.

Now if you echo the `$response`, you will see the `Hello World` printed. 
But we want to build the real http response 
via [Aura.Http][] or something similar to it.

Let us create the real http response with [Aura.Http as in previous post][].

```php
// .... the code above
$transfer = $page->exec();
// ... assuming you have read the earlier post on Aura.Http
$response->setVersion($transfer->getVersion());
$response->setStatusCode($transfer->getStatusCode());
$response->setStatusText($transfer->getStatusText());
$response->headers->setAll($transfer->getHeaders());
$response->cookies->setAll($transfer->getCookies());
$response->setContent($transfer->getContent());
$http->send($response);
```

Now we have the http response. But when we look backward and think 10's 
or 100's of class for which you want to pass so much objects it looks 
horrible. But we don't need to worry too much for we can use [Aura.Di][] 
the Dependency injection container which makes your life much easier.

I am not going to cover [Aura.Di][]. Feel free to look more into it.

It will be good if a front controller can do all the response transfer 
things needed for each page. Let us look into some parts of the [Aura.Framework][]
and learn how it works. The [Aura.Framework][] has a [Front][] controller 
which has an `exec()` method. The `exec()` method calls in the order of 
`pre_exec`, `pre_request` hooks, `request()` method of its own which do the check 
for dispatching of route and getting the right controller and action and 
calling the corresponding `Page` controller and returns the response 
transfer object. Then it will call the `post_request`, `pre_response` 
hooks. Then the `response()` method of it which do the conversion of 
transfer object to real http response and calling the `post_response`, 
`post_exec` hooks.

The hooks are made possible with [Aura.Signal][].

In the instantiation you would have noticed we have passed an object of 
`Aura\Web\Renderer\None`. The [Aura.Web][] doesnot have a rendering strategy 
which helps you to incorporate your own rendering system like [Aura.View][], 
[Twig][] or [Mustache][]....

So here is an example of the rendering strategy build with love for [Twig][]. 
Inorder to create your Rendering object your class must extend 
`Aura\Web\Renderer\AbstractRenderer`.

```php
<?php
namespace Vendor\Package\Web\Renderer;

use Aura\Web\Renderer\AbstractRenderer;

class TwigView extends AbstractRenderer
{
    protected $twig;

    public function __construct(
        \Twig_Environment $twig,
    ) {
        $this->twig    = $twig;
    }

    public function __call($method, array $params)
    {
        return call_user_func_array([$this->twig, $method], $params);
    }

    public function exec()
    {
        $data = $this->controller->getData();
        $response->setContent(
            $this->twig->render(
                $this->getAction() . '.twig', $data
            )
        );
    }
}
```

The `Aura\Web\Controller\AbstractPage` extends the 
`Aura\Web\Controller\AbstractController` which on the construct time call
the `setController` method on the `Aura\Web\Renderer\AbstractRenderer`. 
So you have the object of `Page` available in the `exec()` of the rendering.

So in the `exec()` life cycle of the `Renderer` for the current example 
we are hardcoding it and assuming the view name is always the `action` name.
But it is always good that you can extend `Aura\Web\Controller\AbstractPage` 
and have a `view` property in the class. Thus calling `getView()` on the 
Page will give you the view name. See [Aura\Framework\Web\Controller\AbstractPage][] 
for more details how to make that happen.

Hope that helps you to learn some parts of Aura Framework and building your
own framework with the components of [auraphp][]

[Web Routing in PHP with Aura.Router]: http://phpmaster.com/web-routing-in-php-with-aura-router/
[Aura.Web]: https://github.com/auraphp/Aura.Web
[Aura.Http]: https://github.com/auraphp/Aura.Http
[Mustache]: http://mustache.github.com
[Aura.View]: https://github.com/auraphp/Aura.View
[Twig]: http://twig.sensiolabs.org
[Aura.Di]: https://github.com/auraphp/Aura.Di
[Aura\Framework\Web\Controller\AbstractPage]: https://github.com/auraphp/Aura.Framework/blob/develop/src/Aura/Framework/Web/Controller/AbstractPage.php
[Front]: https://github.com/auraphp/Aura.Framework/blob/develop/src/Aura/Framework/Web/Controller/Front.php
[Aura.Http as in previous post]: http://www.harikt.com/blog/2013/02/16/aura-dot-http-request-and-response/
[Aura.Signal]: https://github.com/auraphp/Aura.Signal
[Context]: https://github.com/auraphp/Aura.Web/blob/develop/src/Aura/Web/Context.php
[Response]: https://github.com/auraphp/Aura.Web/blob/develop/src/Aura/Web/Response.php
[auraphp]: https://github.com/auraphp
