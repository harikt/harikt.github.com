---
layout: post
title: "Composer support for ProcessWire : Part-2"
date: 2013-11-19 08:37
comments: true
categories: [processwire, composer, modules]
---

In my [earlier post](http://harikt.com/blog/2013/11/16/composer-support-for-processwire-modules/) 
I mentioned about adding a `composer.json` in the root of the github repo.

Sometimes you may see a non `composer.json` repo or some times people reject
it, you still can do like the below.

```php
{
    "minimum-stability": "dev",
    "repositories": [
        {
            "type": "package",
            "package": {
                "name": "ryancramerdesign/process-export-profile",
                "version": "1.0.0",
                "source": {
                    "url": "https://github.com/ryancramerdesign/ProcessExportProfile",
                    "type": "git",
                    "reference": "master"
                },
                "type": "pw-module",
                "require": {
                    "hari/pw-module": "dev-master"
                }
            }
        }
    ],    
    "require": {
        "ryancramerdesign/process-export-profile": "1.0.0"
    }
}
```

And run 

```bash
php composer.phar update
```

> Don't forget you need `composer.phar`. If you don't have get from [getcomposer.org](http://getcomposer.org/download/)

The module is downloaded to `site/modules/ProcessExportProfile`. 
The package is of type [pw-module](https://github.com/harikt/pwmoduleinstaller)

> The name process-export-profile is converted to ProcessExportProfile .
> So if you have caps in between name put a hyphen in the naming
