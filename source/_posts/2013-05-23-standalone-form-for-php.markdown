---
layout: post
title: "Standalone form for PHP"
date: 2013-05-23 07:03
comments: true
categories: [auraphp, form, validation, input]
---

Yesterday I wrote about [Standalone Forms and Validation][]. It may need 
a little bit knowledge on how the [Aura.Filter][] works. But that is 
a good start if you want to know how you can integrate the pieces of Aura.

Today I think I need to show you the very minimal approach you can take 
to build the form and validate your form. If you want to
use a powerful validation and filtering use something like [Aura.Filter][] 
or bind your favourite components which does the validation [Respect][], [Symfony2 Validator][], 
[valitron][] and filtering with something like [DMS-Filter][]. 

You can see how you can integrate with different components as I did with 
[Aura.Filter][] in the example in master branch.

I assume you know a bit about [composer] and how to install.

The `composer.json` file

```php
{
    "minimum-stability": "dev",
    "require": {
        "aura/input": "1.0.0-beta1",
        "aura/view": "1.1.2"
    }
}
```

The page which you need to bring the form.

```php
<?php

use Aura\Input\Builder;
use Aura\Input\Filter;
use Aura\Input\Form;

$loader = require __DIR__ . '/vendor/autoload.php';

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
        
        $filter->setRule(
            'name',
            'Name must be alphabetic only.',
            function ($value) {
                return ctype_alpha($value);
            }
        );

        $filter->setRule('email', 'Enter a valid email address', function ($value) {
            return filter_var($value, FILTER_VALIDATE_EMAIL);
        });

        $filter->setRule('url', 'Enter a valid url', function ($value) {
            return filter_var($value, FILTER_VALIDATE_URL);
        });

        $filter->setRule('message', 'Message should be more than 7 characters', function ($value) {
            if (strlen($value) > 7) {
                return true;
            }
            return false;
        });
    }
}

$form = new ContactForm(new Builder(), new Filter());

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
function showFieldErrors($form, $name) {
    $errors = $form->getMessages($name);
    $str = '';
    if ($errors) {
        $str .= '<ul>';
        foreach ($errors as $error) {
            $str .= '<li>' . $error . '</li>';
        }
        $str .= '</ul>';
    }
    return $str;
}
?>
<html>
<head>
    <title>Aura Form, to make it standalone</title>
</head>
<body>
    <form method="post" action="" enctype="multipart/form-data" >
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td>Name : </td>
                <td>
                <?php
                    echo $field($form->get('name'));
                    echo showFieldErrors($form, 'name');
                ?>
                </td>
            </tr>
            <tr>
                <td>Email : </td>
                <td>
                <?php
                    echo $field($form->get('email'));
                    echo showFieldErrors($form, 'email');
                ?>
                </td>
            </tr>
            <tr>
                <td>Url : </td>
                <td>
                <?php
                    echo $field($form->get('url'));
                    echo showFieldErrors($form, 'url');
                ?>
                </td>
            </tr>
            <tr>
                <td>Message : </td>
                <td>
                <?php
                    echo $field($form->get('message'));
                    echo showFieldErrors($form, 'message');
                ?>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                <?php 
                echo $field($form->get('submit'));
                ?>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
```

That's it. Pretty clear I guess. Still having trouble?
The whole code lies in the [minimalview][] branch of the [phpform][].

[Standalone Forms and Validation]: http://harikt.com/blog/2013/05/21/standalone-forms-and-validation/
[Aura.Filter]: http://auraphp.com/packages
[Respect]: https://github.com/Respect/Validation
[Symfony2 Validator]: https://github.com/symfony/validator
[valitron]: https://github.com/vlucas/valitron
[DMS-Filter]: https://github.com/rdohms/DMS-Filter
[composer]: http://getcomposer.org
[minimalview]: https://github.com/harikt/phpform/tree/minimalview
[phpform]: https://github.com/harikt/phpform
