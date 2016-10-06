---
layout: post
title: "Composer support for ProcessWire modules"
date: 2013-11-16 11:22
comments: true
categories: [composer, processwire, modules]
---

I am a huge fan of [composer][]. [PW][] ( ProcessWire) is missing one of the good parts of [composer][].
So here is a [new installer](https://github.com/harikt/pwmoduleinstaller)
to install the 3rd party modules of [PW][] via [composer][].

If you have created a module for PW, what you need to do is add a
`composer.json` file in your [github repo][] and add it to [packagist][].
An example [composer.json][github repo] is

```json
{
    "name": "vendor/package-name",
    "type": "pw-module",
    "description": "Your module what it does",
    "keywords": [ "keywords", "comma", "seprated"],
    "homepage": "https://github.com/harikt/Assets",
    "license": "BSD-2-Clause",
    "authors": [
        {
            "name": "Assets Contributors",
            "homepage": "https://github.com/harikt/Assets/contributors"
        }
    ],
    "require": {
        "php": ">=5.3.0",
        "hari/pw-module": "~1.0"
    }
}
```

Note the minimum requirement is PHP 5.3 for composer is 5.3 .

An example of a module that works with this is https://github.com/harikt/Assets
( Move the index.php to any where :-) ).
You are read more about Assets from [here](http://harikt.com/blog/2013/11/08/assets-for-processwire/)

## Installing modules

How do you install the PW modules and the 3rd party dependencies ? Assuming you are in the PW folder.

First download composer from [http://getcomposer.org/download/](http://getcomposer.org/download/).

Hope you have `composer.phar` now.


```bash
php composer.phar require vendor/package-name version-name
```

Will install if the `vendor/package-name` to `site/modules/PackageName`.
All packages `vendor/package-name` of `"type": "pw-module"` will be converted to `PackageName`.

Example you can try

```bash
php composer.phar require hari/assets dev-master
```

Try the above and see where it is installed. If you are a module maintainer,
please add a `composer.json` to your github module and add it to [packagist][].

Of-course inspired and modified composer installer from
[Aura Project for PHP](https://github.com/auraphp/installer-system)

Thank you. Happy PhPing!

  [github repo]: https://github.com/harikt/Assets/blob/master/composer.json "External link"
  [packagist]: https://packagist.org "External link"
  [composer]: http://getcomposer.org/ "External link"
  [PW]: http://processwire.com/
