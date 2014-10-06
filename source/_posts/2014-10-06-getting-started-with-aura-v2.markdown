---
layout: post
title: "Getting started with aura v2"
date: 2014-10-06 08:55:41 +0530
comments: true
categories: [auraphp]
---

Yesterday [aura framework v2 stable released](http://auraphp.com/blog/2014/10/05/stable-project-releases/).

Lots of complains about documentation or missing documentation. So this is a quick start. Probably a five minutes walk through. Learn and change to make it better.


## Creating your project

Create the project using composer.

```bash
composer create-project aura/web-project quick-start
cd quick-start
```

The minimal framework don't come with any sort of view integrated. Let us use `aura/view`, the two step templating with the help of `foa/html-view-bundle`.

```
composer require "foa/html-view-bundle:~2.0"
```

We will be keeping all the templates in `templates` folder where views in `templates/views` and layout in `templates/layouts`.

```bash
mkdir -p templates/{views,layouts}
```

Edit `config/Common.php` and define service for `view`.

```php
public function define(Container $di)
{
    $di->set('view', $di->lazyNew('Aura\View\View'));
}
```

add a way to set the path to templates. Assuming you have `templates` folder in the root. There is no finder in `aura/view` to increase the performance of loading and rendering templates. For a quick hack let us iterate through the directory and set all the views and layouts to its registry.

```php
public function modify(Container $di)
{
    // more code
    $this->defineTemplates($di);
}

public function defineTemplates($di)
{
    $view = $di->get('view');
    $view_registry = $view->getViewRegistry();
    $view_directory = dirname(__DIR__) . '/templates/views/';
    $iterator = new \DirectoryIterator($view_directory);
    foreach ($iterator as $fileinfo) {
        if ($fileinfo->isFile()) {
            $view_registry->set($fileinfo->getBasename('.php'), $fileinfo->getPathname());
        }
    }

    $layout_registry = $view->getLayoutRegistry();
    $layout_directory = dirname(__DIR__) . '/templates/layouts/';
    $iterator = new \DirectoryIterator($layout_directory);
    foreach ($iterator as $fileinfo) {
        if ($fileinfo->isFile()) {
            $layout_registry->set($fileinfo->getBasename('.php'), $fileinfo->getPathname());
        }
    }
}
```

Edit `modifyDispatcher` method to

```php
public function modifyWebDispatcher($di)
{
    $dispatcher = $di->get('aura/web-kernel:dispatcher');

    $view = $di->get('view');
    $response = $di->get('aura/web-kernel:response');
    $request = $di->get('aura/web-kernel:request');
    $dispatcher->setObject('hello', function () use ($view, $response, $request) {
        $name = $request->query->get('name', 'Aura');
        $view->setView('hello');
        $view->setLayout('default');
        $view->setData(array('name' => $name));
        $response->content->set($view->__invoke());
    });
}
```

Create your basic template `templates/views/hello.php`

```php
<?php // templates/views/hello.php ?>
<?php $this->title()->set("Hello from aura"); ?>
<p>Hello <?= $this->name; ?></p>
```

and a very basic layout

```php
<?php // templates/layouts/default.php ?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-us">
  <head>
    <?php echo $this->title(); ?>
  </head>
  <body>
    <?php echo $this->getContent(); ?>
  </body>
</html>
```

Let us fire the php server

```bash
php -S localhost:8000 web/index.php
```

and point your browser to `http://localhost:8000` .

Probably very simple way how to use [aura](http://auraphp.com) as a micro framework!.

You can see the [example over github](https://github.com/harikt/quick-start).

## What is next?

Read [Aura Framework v2 : The missing Manual](https://leanpub.com/aurav2/) and  [report/contribute](https://github.com/harikt/aurav2book) to the book.
