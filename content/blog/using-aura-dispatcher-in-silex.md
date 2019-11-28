+++
title = "using aura dispatcher in silex"
date = "2013-11-06"
slug = "2013/11/06/using-aura-dispatcher-in-silex"
Categories = []
+++

2 days back [Paul M Jones](http://paul-m-jones.com/) wrote an awesome post 
[A Peek At Aura v2 -- Aura.Dispatcher](http://auraphp.com/blog/2013/11/04/aura-v2-dispatcher/) 
the idea behind [Aura.Dispatcher](http://github.com/auraphp/Aura.Dispatcher/) 
and how it was born.

So today, let us try to integrate 
[Aura.Dispatcher](http://github.com/auraphp/Aura.Dispatcher) with 
[Silex](https://github.com/silexphp/Silex). This post is inspired by the 
[comment](http://auraphp.com/blog/2013/11/04/aura-v2-dispatcher/#comment-1109657910) 
made by [Luis Cordova](https://twitter.com/cordoval). Thank you.


```bash
composer create-project silex/silex --no-dev silexproject
cd silexproject
composer require aura/dispatcher dev-develop-2
```

> I hope you have composer installed else [get composer](http://getcomposer.org/).

I am not going to explain each and everything, the code is self explanatory.
You can move the classes according to your wish (may be to another folder). 
I am trying to show a simple use case. 

```php
<?php
require __DIR__ . '/vendor/autoload.php';

use Aura\Dispatcher\Dispatcher;

$dispatcher = new Dispatcher;

$dispatcher->setMethodParam('action');
$dispatcher->setObjectParam('controller');

class Blog
{
    public function browse()
    {
        // ...
    }

    public function hello($name, $app)
    {
        return 'Hello '. ucfirst($app->escape($name));
    }

    public function edit($id)
    {
        echo "Here";
        exit;
        // ...
    }

    public function add()
    {
        // ...
    }

    public function delete($id)
    {
        // ...
    }
}

$dispatcher->setObject('blog', function () {
    return new Blog;
});

$app = new Silex\Application();

$app->get('/hello/{name}', function ($name) use ($dispatcher, $app) {
    $params = [
        'controller' => 'blog',
        'action' => 'hello',
        'name' => $name,
        'app' => $app,
    ];
    $result = $dispatcher->__invoke($params);    
    return $result;
});

$app->run();
```

See how we moved the `return 'Hello '. ucfirst($app->escape($name));` 
to a controller and action. I haven't used Silex extensively, so there 
can be better ways for integration.

> Update : I was asking [Beau D. Simensen](https://twitter.com/beausimensen) 
> on the integration, and he gave another shot.

```php
// all code as same as above, upto the route

$app->get('/hello/{name}', function ($name) use ($app) {
    return [
        'controller' => 'blog',
        'action' => 'hello',
        'name' => $name,
        'app' => $app,
    ];
});

$app->on(\Symfony\Component\HttpKernel\KernelEvents::VIEW, function ($event) use ($app, $dispatcher) {
    $view = $event->getControllerResult();

    if (is_null($view) || is_string($view)) {
        return;
    }
    
    if ( ! is_array($view)) {
        // we can only handle array data in the view
        return;
    }
    
    if (! (isset($view['controller']) && isset($view['action']))) {
        // at this point we don't know what is going on.
        return;
    }

    $response = $dispatcher($view);

    if ( ! $response instanceof \Symfony\Component\HttpFoundation\Response) {
        // If the response is not a Response instance, wrap it in one
        // and assume that it was something appropriate as a response
        // body.
        $response = new \Symfony\Component\HttpFoundation\Response($response);
    }

    $event->setResponse($response);
});

$app->run();
```

> I have purposefully kept the full path like `\Symfony\Component\HttpFoundation\Response`

Hope you love [Aura.Dispatcher](http://github.com/auraphp/Aura.Dispatcher)
and use when you need architecural changes.

Please do take time to read 
[Refactoring To Architecture Changes](https://github.com/auraphp/Aura.Dispatcher#refactoring-to-architecture-changes)

Thank you and if you loved the post please do a tweet :-).

Happy PhPing!
