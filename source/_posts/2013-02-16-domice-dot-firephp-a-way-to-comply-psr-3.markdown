---
layout: post
title: "Domicile.FirePHP a way to comply PSR-3"
date: 2013-02-16 13:15
comments: true
categories: 
---

[Domicile.FirePHP][] is an experiment to make [FirePHP][] works for [PSR-3][].

This is not a replacement for the original [FirePHP][]. It has dependencies 
on `firephp/firephp-core`, and `psr/log`

The package is compliant with  [PSR-0][], [PSR-1][], [PSR-2][]. If you notice 
compliance oversights, please send a patch via pull request.

Installation:
=============

You can install it via composer. Add `domicile/firephp` in your require

    {
        "require": {
            "domicile/firephp": "dev-master"
        }
    }
    
And run `composer update`

Instantiation and Usage:
========================

Create an object of `Domicile\FirePHP\FirePHP`, which will give you, an 
instance of the `\FirePHP::getInstance(true)`.

```php
<?php
$firephp = new \Domicile\FirePHP\FirePHP();
```
    
Now you can use 

```php
<?php
$firephp->info("Hello World");
$firephp->warn("Trying to make it PSR-3");
$firephp->error("This is still not fully PSR-3");
```
    
Or you can get the `FirePHP` object by calling 
   
```php
<?php
$object = $firephp->getFirePHP();
```
    
And you can make use of the real functionalities of the core [FirePHP][]
   
```php
<?php
$object->log(
    array('2 SQL queries took 0.06 seconds',
        array(
            array('SQL Statement','Time','Result'),
            array('SELECT * FROM Foo','0.02',array('row1','row2')),
            array('SELECT * FROM Bar','0.04',array('row1','row2'))
        )
    ),
    \FirePHP::TABLE
);
```

Known Limitations:
==================

In [FirePHP][] I didn't noticed it is having `LogLevel::ALERT`, `LogLevel::CRITICAL`, 
`LogLevel::DEBUG`, `LogLevel::EMERGENCY`, `LogLevel::NOTICE` levels.

I am not sure whether `trace` can be used for `DEBUG`.

Also the [PSR-3][] states that 

Calling this method with a level not defined by this specification MUST 
throw a `Psr\Log\InvalidArgumentException` if the implementation does not 
know about the level. Users SHOULD NOT use a custom level without knowing 
for sure the current implementation supports it.

But the current way is logging it to console with the corresponding level.

If you have any suggestions please let me know what we can do for this.

To Rethink:
===========

Do we need to add a `getInstance()` method?

What are your thoughts on the same?

[Domicile.FirePHP]: https://github.com/harikt/Domicile.FirePHP
[PSR-3]: https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md
[FirePHP]: https://github.com/firephp/firephp-core
[PSR-0]: https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md
[PSR-1]: https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-1-basic-coding-standard.md
[PSR-2]: https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-2-coding-style-guide.md
