+++
title = "improving environment value in aura v2"
date = "2014-12-12"
slug = "2014/12/12/improving-environment-value-in-aura-v2"
Categories = []
+++

Aura v2 framework probably have missed a better way to handle environment variables. But that doesn't make you stall. Things can be improved ;-).

> Assume you are already using aura framework and is at root of the project.

We are going to make use of [vlucas/phpdotenv](https://github.com/vlucas/phpdotenv) , alternatives are there if you are interested to experiment.

```bash
composer require vlucas/phpdotenv
```

Edit the file `config/_env.php` and add `Dotenv::load(/path/to/.env);` to the first line. If you have not modified anything it will look as below

```php
<?php
// {PROJECT_PATH}/config/_env.php
Dotenv::load(__DIR__);
// set the mode here only if it is not already set.
// this allows for setting via web server, shell script, etc.
if (! isset($_ENV['AURA_CONFIG_MODE'])) {
    $_ENV['AURA_CONFIG_MODE'] = 'dev';
}
```

> Don't forget to create the `.env` file.

You are done!

Now you can easily make use of environment variables easily from the configuration files.

Below is an example.


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
