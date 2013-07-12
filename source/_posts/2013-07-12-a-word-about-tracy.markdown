---
layout: post
title: "A word about Tracy"
date: 2013-07-12 13:31
comments: true
categories: [tracy, debugger, nette]
---

Tracy is a wonderful component from the 
[nette framework project](http://nette.org).

I have been looking at tracy for a while. It has nice awesome panel for 
you to dump and debug things.

Looking exceptions are handy.

![Tracy Panel](http://harikt.com/images/tracy.png)

## Installation ##

It is easy to install with composer. So your composer.json will be 
something like below.

```php
{
    "minimum-stability": "dev",
    "require": {
        "tracy/tracy": "dev-master"
    }
}
```

and finally run the `composer.phar update`

## Enabling the Debugger ##

In-order to enable the debugger, you need to add two lines. 

```php
use Tracy\Debugger;

Debugger::enable();
```

> Assuming you have already added a line `require_once 'path/to/vendor/autoload.php';`

## Dump Data ##

There are a variety of options which you can dump data. Some of 
them are to firebug, firelogger etc.

In this  I am interested to show you how to dump data to the 
debug bar.

```php
Debugger::barDump('Some SQL Query', 'SQL');
Debugger::barDump(array('foo' => 'bar'), 'bar');
```

The panel is smart enough to understand and float 
where it stayed when you last opened it.

Try it out guys!
