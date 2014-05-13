---
layout: post
title: "Extending Plates with Aura Html Helpers"
date: 2014-05-13 09:13:47 +0530
comments: true
categories: [auraphp, plates, html, helpers, view, php] 
---

[Aura.Html][] provides HTML escapers and helpers, including form input helpers, 
that can be used in any template, view, or presentation system.

In this post I would like to give you a short introduction to Aura.Html 
and how you could use with [Plates][] a native php templating system like [Aura.View][].

[Aura.Html][] was extracted from [Aura.View][] helper functions of version 1, 
when we at aura noticed that people who uses [Aura.Input][] may need some html helper 
functions and they may not be using a templating like [Aura.View][], 
but some other templating system.

You can see an example of a simple [contact form](http://harikt.com/phpform/) with [Aura.Input][].

## Installation

The easiest way to install Aura.Html is via composer. Let us create our `composer.json`

```json
{
    "require": {
        "aura/html": "2.*@dev",
        "league/plates": "2.*"
    }
}
```

One of the good thing about Plates is you can create [extensions](http://platesphp.com/extensions/).

Let us create an extension that can make use of [Aura.Html][] helpers inside [Plates][]. 
Any Plates extension should implement `League\Plates\Extension\ExtensionInterface`
which contains a `getFunctions` method which returns the functions 
available within your templates.

We are going to name it as `AuraHtmlExtension` and call functions as 
`aurahtml()` or `html()` via the template.

```php
<?php
use League\Plates\Extension\ExtensionInterface;
use Aura\Html\HelperLocator;

class AuraHtmlExtension implements ExtensionInterface
{
    public $engine;

    public $template;

    protected $helper;

    public function __construct(HelperLocator $helper)
    {
        $this->helper = $helper;
    }

    public function getFunctions()
    {
        return array(
            'aurahtml' => 'callHelper',
            'html' => 'callHelper'
        );
    }

    public function callHelper()
    {
        return $this->helper;
    }
}
```

But you are not limited to name it as the same 
[html tag helpers](https://github.com/auraphp/Aura.Html/blob/functions/README-HELPERS.md#aurahtml-tag-helpers)
and [form helpers](https://github.com/auraphp/Aura.Html/blob/develop-2/README-FORMS.md).

So that will make the helpers look native Plates helpers. Thank you for
this functionality to plugin the helpers.

```php
<?php
use League\Plates\Extension\ExtensionInterface;
use Aura\Html\HelperLocator;

class AuraHtmlExtension implements ExtensionInterface
{
    public $engine;

    public $template;

    protected $helper;

    public function __construct(HelperLocator $helper)
    {
        $this->helper = $helper;
    }

    public function getFunctions()
    {
        return array(
            'anchor' => 'anchor'
            // ... more functions same as aura
        );
    }
    
    public function anchor($href, $text, array $attr = array())
    {
        return $this->helper->anchor($href, $text, array $attr);
    }
}
```

Let us use the [basic example in plates](http://platesphp.com/simple-example/) 
and use aura html helper to show the system works as expected.

Create the templates in a `templates` folder or change the path in Plates Engine.

### Profile Template

```php
<!-- profile.php -->

<?php $this->layout('template') ?>

<?php $this->title = 'User Profile' ?>

<h1>User Profile</h1>
<p>Hello, <?=$this->e($this->name)?></p>
<div>
<?php
echo $this->aurahtml()->input(array(
    'type'    => 'color',
    'name'    => 'name',
    'value'   => 'value',
    'attribs' => array(),
    'options' => array(),
));

// <input type="color" name="name" value="value" />
echo $this->html()->input(array(
    'type'    => 'date',
    'name'    => 'name',
    'value'   => 'value',
    'attribs' => array(),
    'options' => array(),
));

// <input type="date" name="name" value="value" />
?>
</div>
```

### Layout Template

```php
<!-- template.php -->

<html>
<head>
    <title><?=$this->title?></title>
</head>

<body>

<?=$this->content()?>

</body>
</html>
```

### Autoload Extension

Make sure AuraHtmlExtension can be autoloaded. We can add in `composer.json`

```json
    // rest of the code    
    "autoload": {
        "psr-4": {
            "": "path/to/aura/html/extension/"
        }
    }
```

### Bootstrapping and Rendering

```php
// test.php file
require __DIR__ . '/vendor/autoload.php';
$engine = new \League\Plates\Engine( __DIR__ . '/templates');

// Create a new template
$template = new \League\Plates\Template($engine);
$factory = new \Aura\Html\HelperLocatorFactory();
$helper = $factory->newInstance();
$engine->loadExtension(new AuraHtmlExtension($helper));

// Assign a variable to the template
$template->name = 'Jonathan';

// Render the template
echo $template->render('profile');
```

If you run `php test.php` you will see something like this rendered.

```html
<html>
<head>
    <title>User Profile</title>
</head>

<body>


<h1>User Profile</h1>
<p>
Hello, Jonathan
</p>
<div>
<input type="color" name="name" value="value" />
<input type="date" name="name" value="value" />
</div>

</body>
</html>
</body></title>
```

Thank you and Happy PhPing!

[Aura.Html]: https://github.com/auraphp/Aura.Html
[Aura.Input]: https://github.com/auraphp/Aura.Input
[Aura.View]: https://github.com/auraphp/Aura.View
[Plates]: http://platesphp.com
