---
layout: post
title: "Improving environment value in Aura v2"
date: 2014-12-12 20:18:13 +0530
comments: true
categories: [auraphp, .env]
---

Aura v2 framework probably have missed a better way to environment variables. But that doesn't make you stall. Things can be improved ;-) .

> Assume you are already using aura framework and is on the root of the project.

We are going to make use of [vlucas/phpdotenv](https://github.com/vlucas/phpdotenv) , alternatives are there if you are interested to experiment.

```bash
composer require vlucas/phpdotenv
```

Edit the file `config/_env.php` add `Dotenv::load(/path/to/.env);` to the first line.

> Don't forget to create the `.env` file.

You are done!

Now you can easily make use of environment values easily from the configuration files. Below is an example.


```php
<?php
namespace Aura\Framework_Project\_Config;
// config/Common.php

use Aura\Di\Config;
use Aura\Di\Container;

class Common extends Config
{
    public function define(Container $di)
    {
        $di->params['Aura\Sql\ExtendedPdo'] = array(
            'dsn' => getenv('dsn'),
            'username' => getenv('username'),
            'password' => getenv('password'),
        );
    }

    // more code
```
