+++
title = "aura turns 2"
date = "2013-02-22"
slug = "2013/02/22/aura-turns-2"
Categories = []
+++

Looking over [the commits on Aura.Router][], [Aura.Signal][] etc you will 
notice, [aura project][] has turned 2.

And today, I would like to introduce you, the new born baby still under active 
development and refactoring based on user feedback, the 
[form library for php, Aura.Input][].

The [Aura.Input], doesn't have a rendering functionality. But you can always 
use Aura.View or create your own helpers.

A basic filtering based on closure exists in [Aura.Input][]. But you are 
not limited, you can use your own filtering components or 
integrate [Aura.Filter][].

Let us look at some code.

```php
<?php
// use composer or require '/path/to/Aura.Input/src.php';

use Aura\Input\Form;
use Aura\Input\Builder;
use Aura\Input\Filter;

$filter = new Aura\Input\Filter();

// validate
$filter->setRule('name', 'Name should be alpha only', function ($value) {
    return ctype_alpha($value);
});

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

class ContactForm extends Form
{
    public function init()
    {
        $name    = $this->setField('name');
        $email   = $this->setField('email');
        $url     = $this->setField('url');
        $message = $this->setField('message', 'textarea');
    }
}

$form = new ContactForm(new Builder, $filter);

$values = [
    'name' => 'Hari K T',
    'email' => 'oh will it works!',
    'url' => 'google.com',
    'message' => 'Aweso'
];

$form->setValues($values);

$passed = $form->filter();

// 'foo' is invalid
if (! $passed) {
    // get all messages
    $actual = $form->getMessages();
    var_dump($actual);
}
```

Try it out, we have some more documentation for the [Aura.Input][]. I warn 
the api is still not stable for [Aura.Input][] and is not yet released a Beta.

But it is a good start!

[the commits on Aura.Router]: https://github.com/auraphp/Aura.Router/commit/8de403dc49bf803a1fd641f55726079853716ab7
[form library for php, Aura.Input]: https://github.com/auraphp/Aura.Input
[aura project]: https://github.com/auraphp
[Aura.Signal]: https://github.com/auraphp/Aura.Signal
[Aura.Input]: https://github.com/auraphp/Aura.Input
[Aura.Filter]: https://github.com/auraphp/Aura.Filter
