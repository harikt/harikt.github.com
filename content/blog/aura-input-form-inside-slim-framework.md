+++
title = "aura input form inside slim framework"
date = "2014-09-02"
slug = "2014/09/02/aura-input-form-inside-slim-framework"
Categories = []
+++

Rob Allen wrote about [Integrating ZF2 forms into Slim](http://akrabat.com/zend-framework-2/integrating-zf2-forms-into-slim/).
I did write how you can use [Aura.Input](https://github.com/auraphp/Aura.Input/tree/develop) and [Aura.Html](https://github.com/auraphp/Aura.Html) to create [standalone form for PHP](http://harikt.com/phpform/).
This time I felt I should write about integrating aura input inside [Slim](http://slimframework.com/).

Let us install a few dependencies `aura/input` for building the form and
`aura/html` for the html helpers. You of-course can skip not to use `aura/html`
and build your own helper. I also purposefully left not integrating the powerful 
[Aura.Filter](https://github.com/auraphp/Aura.Filter/tree/develop) , but you 
are not limited to integrate any validator you love inside Aura.Input .

The full `composer.json` is as below.

```json
{
    "require": {
        "slim/slim": "2.*",
        "aura/html": "2.0.0",
        "aura/input": "1.*"
    },
    "autoload":{
        "psr-0":{
            "": "src/"
        }
    }
}
```

We will keep `ContactForm.php` under `src` folder. ie why you see the
`autoload` in `composer.json`. The form looks as below.

```php
<?php
// src/ContactForm.php

use Aura\Input\Form;

class ContactForm extends Form
{
    public function init()
    {
        $this->setField('name')
            ->setAttribs([
                'id' => 'contact[name]',
                'name' => 'contact[name]',
                'size' => 20,
                'maxlength' => 20,
            ]);
        $this->setField('email')
            ->setAttribs([
                'id' => 'contact[email]',
                'name' => 'contact[email]',
                'size' => 20,
                'maxlength' => 20,
            ]);
        $this->setField('url')
            ->setAttribs([
                'id' => 'contact[url]',
                'name' => 'contact[url]',
                'size' => 20,
                'maxlength' => 20,
            ]);
        $this->setField('message', 'textarea')
            ->setAttribs([
                'id' => 'contact[message]',
                'name' => 'contact[message]',
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

        $filter->setRule(
            'email',
            'Enter a valid email address',
            function ($value) {
                return filter_var($value, FILTER_VALIDATE_EMAIL);
            }
        );

        $filter->setRule(
            'url',
            'Enter a valid url',
            function ($value) {
                return filter_var($value, FILTER_VALIDATE_URL);
            }
        );

        $filter->setRule(
            'message',
            'Message should be more than 7 characters',
            function ($value) {
                if (strlen($value) > 7) {
                    return true;
                }
                return false;
            }
        );
    }
}
```

The entry point `web/index.php` looks as below.

```php
<?php
// web/index.php

use Aura\Input\Builder;
use Aura\Input\Filter;

require dirname(__DIR__) . '/vendor/autoload.php';
$app = new \Slim\Slim(array(
    'templates' => dirname(__DIR__) . '/templates'
));
$app->map('/contact', function () use ($app) {
    $form = new ContactForm(new Builder(), new Filter());
    if ($app->request->isPost()) {
        $form->fill($app->request->post('contact'));
        if ($form->filter()) {
            echo "Yes successfully validated and filtered";
            var_dump($data);
            $app->halt();
        }
    }
    $app->render('contact.php', array('form' => $form));
})->via('GET', 'POST')
->name('contact');

$app->run();
```

The template `contact.php` resides under templates folder.

```php
<?php
// templates/contact.php

use Aura\Html\HelperLocatorFactory;

$factory = new HelperLocatorFactory();
$helper = $factory->newInstance();

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
    <title>Aura input form, inside slim framework</title>
</head>
<body>
    <form method="post" action="<?php echo $app->urlFor('contact'); ?>" enctype="multipart/form-data" >
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td>Name : </td>
                <td>
                <?php
                    echo $helper->input($form->get('name'));
                    echo showFieldErrors($form, 'name');
                ?>
                </td>
            </tr>
            <tr>
                <td>Email : </td>
                <td>
                <?php
                    echo $helper->input($form->get('email'));
                    echo showFieldErrors($form, 'email');
                ?>
                </td>
            </tr>
            <tr>
                <td>Url : </td>
                <td>
                <?php
                    echo $helper->input($form->get('url'));
                    echo showFieldErrors($form, 'url');
                ?>
                </td>
            </tr>
            <tr>
                <td>Message : </td>
                <td>
                <?php
                    echo $helper->input($form->get('message'));
                    echo showFieldErrors($form, 'message');
                ?>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                <?php
                echo $helper->input($form->get('submit'));
                ?>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
```

> NB: If you need to reuse the functionality of `showFieldErrors` keep it on a separate file and require it.

Thank you [Andrew Smith](https://twitter.com/silentworks), [Christian Schorn](https://twitter.com/cschorn) for the proof reading and tips provided. 

I hope you will find something interesting in the integration!.

[Download and play with code from github](https://github.com/harikt/slim-aura-form)
