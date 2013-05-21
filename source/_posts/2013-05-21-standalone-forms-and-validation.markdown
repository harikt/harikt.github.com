---
layout: post
title: "Standalone Forms and Validation"
date: 2013-05-21 20:15
comments: true
categories: [auraphp, form, filter]
---

Recently [Aura.Input][] was tagged Beta1. I would like to show you how you 
can use [Aura.Input][], [Aura.Filter][] and [Aura.View][] to create form.

The [Aura.Input][] itself contains a basic filter implementation. As shown 
in earlier post [Aura Turns 2][]

But in this post let us use the power of [Aura.Filter][]. As [Aura.Input][]
doesn't have a rendering capability you may need to use [Aura.View][] as 
templating system ( see Using Aura.View ) or use the helper classes provided by [Aura.View][] 
( see below Without using Aura.View completely )
or create your own helper classes to render the same from the hints
( see Hints for the view ).

The whole example is in [https://github.com/harikt/form-example][] repo.
If you don't have composer, you can download it from [http://getcomposer.org][]
and install the dependencies via composer.

In a nut shell
--------------

```
git clone https://github.com/harikt/form-example
cd form-example
php composer.phar install
php -S localhost:8000 web/index.php
```

Point your browser to the url http://localhost:8000

Let us look into some details
-----------------------------

Inorder to use [Aura.Filter][] with [Aura.Input][] we need to implement the 
`Aura\Input\FilterInterface`.

This is just extending the `Aura\Filter\RuleCollection` and implementing 
the `Aura\Input\FilterInterface` as below.

```php
<?php
namespace Domicile\Example;

use Aura\Filter\RuleCollection;
use Aura\Input\FilterInterface;

class Filter extends RuleCollection implements FilterInterface
{
}

```

Let us create the form class.

```php
<?php
namespace Domicile\Example;

use Aura\Input\Form;

class ContactForm extends Form
{
    public function init()
    {
        $this->setField('name')
            ->setAttribs([
                'id' => 'name',
                'size' => 20,
                'maxlength' => 20,
            ]);
        $this->setField('email')
            ->setAttribs([
                'size' => 20,
                'maxlength' => 20,
            ]);
        $this->setField('url')
            ->setAttribs([
                'size' => 20,
                'maxlength' => 20,
            ]);
        $this->setField('message', 'textarea')
            ->setAttribs([
                'cols' => 40,
                'rows' => 5,
            ]);
        $this->setField('submit', 'submit')
            ->setAttribs(['value' => 'send']);
        
        $filter = $this->getFilter();
        
        $filter->addSoftRule('name', $filter::IS, 'string');
        $filter->addSoftRule('name', $filter::IS, 'strlenMin', 4);
        $filter->addSoftRule('email', $filter::IS, 'email');
        $filter->addSoftRule('url', $filter::IS, 'url');
        $filter->addSoftRule('message', $filter::IS, 'string');
        $filter->addSoftRule('message', $filter::IS, 'strlenMin', 6);
    }
}

```

Create the filter object and pass it on instantiation of form. 

Please note that the $rootpath in this example is just above the vendor 
folder of the composer.

```php
$filter = new Domicile\Example\Filter(
    new RuleLocator(array_merge(
        require $rootpath . '/vendor/aura/filter/scripts/registry.php',
        ['any' => function () {
            $rule = new \Aura\Filter\Rule\Any;
            $rule->setRuleLocator(new RuleLocator(
                require $rootpath . '/vendor/aura/filter/scripts/registry.php'
            ));
            return $rule;
        }]
    )),
    new Translator(require $rootpath . '/vendor/aura/filter/intl/en_US.php')
);

$form = new Domicile\Example\ContactForm(new Builder, $filter);
```

The [Aura.Input][] has two methods we can make use. 

1 ) fill() method helps us to fill the data values

2 ) filter() method which helps to filter and validate data according to 
the rules specified in the form.

The code will looks like

```php

if ($_POST && $_POST['submit'] == 'send') {
    $data = $_POST;
    $form->fill($data);
    if ($form->filter()) {
        //
        echo "Yes successfully validated and filtered";
        var_dump($data);
        exit;
    }
}
```

The form element gives you hints for the view. An example from the above

Hints for the view
------------------

```php
// get the hints for the name field
$hints = $form->get('name');

// the hints array looks like this:
$hints = array (
  'type' => 'text',
  'name' => 'name',
  'attribs' => 
  array (
    'id' => 'name',
    'type' => NULL,
    'name' => NULL,
    'size' => 20,
    'maxlength' => 20,
  ),
  'options' => 
  array (
  ),
  'value' => NULL,
)
```

Without using Aura.View completely
----------------------------------

If you are not planning to use Aura.View entirely as templating, you can 
make use of [Aura.View][] helpers which can render to make the form.

For that you need to instantiate `Aura\View\HelperLocator` and get the 
field object as below.

```php
$helper = new Aura\View\HelperLocator([
    'field'         => function () { 
        return new Aura\View\Helper\Form\Field(
            require dirname(__DIR__) . '/vendor/aura/view/scripts/field_registry.php'
        ); 
    },
    'input'         => function () { return new Aura\View\Helper\Form\Input(
            require dirname(__DIR__) . '/vendor/aura/view/scripts/input_registry.php'
        ); 
    },
    'radios'        => function () { return new Aura\View\Helper\Form\Radios(new Aura\View\Helper\Form\Input\Checked); },
    'repeat'         => function () { return new Aura\View\Helper\Form\Repeat(
            require dirname(__DIR__) . '/vendor/aura/view/scripts/repeat_registry.php'
        ); 
    },
    'select'        => function () { return new Aura\View\Helper\Form\Select; },
    'textarea'      => function () { return new Aura\View\Helper\Form\Textarea; },
]);

$field = $helper->get('field');
echo $field($form->get('name'));
echo $field($form->get('message'));

// echo $field($form->get('form-element'));

```

The above will output something like

`<input id="name" type="text" name="name" size="20" maxlength="20" />`

Using Aura.View
---------------

But you can use [Aura.View][] to render it nicely. An example is 

```php
<?php
    echo $this->field($this->form->get('name'));
?>
```
You can still look more closely on the [templates][] to see how it is used
in the example.

If you have any problems or confusions, let me know by comments. 
I will try to address the same.

I would like to express huge Thanks to Paul M Jones for spending his 
valuable time on the project, giving valuable feedback on the implementations.

Happy PhPing!

[Aura Turns 2]: http://harikt.com/blog/2013/02/22/aura-turns-2/
[Aura.Input]: http://auraphp.com/Aura.Input/
[Aura.Filter]: http://auraphp.com/Aura.Filter/
[Aura.View]: http://auraphp.com/Aura.View/
[https://github.com/harikt/form-example]: https://github.com/harikt/form-example
[templates]: https://github.com/harikt/form-example/blob/master/templates/default.php
[http://getcomposer.org]: http://getcomposer.org
