---
layout: post
title: "Hidden gems of composer"
date: 2014-05-29 07:53:53 +0530
comments: true
categories: [php, composer, patch, bug-fix]
---

I hope everyone in the PHP world is aware of [composer][] the dependency 
management tool that gives an end to Pear.

We can look into some of the hidden gems of composer. Some of them are 
already documented in the composer docs.

## Bug Fixing :

Documented over [Loading a package from a VCS repository](https://getcomposer.org/doc/05-repositories.md#loading-a-package-from-a-vcs-repository)

```json
{
    "repositories": [
        {
            "type": "vcs",
            "url": "https://github.com/igorw/monolog"
        }
    ],
    "require": {
        "monolog/monolog": "dev-bugfix"
    }
}
```

The above example assume you have pushed your code to github. But you can 
also make use of the local directory.

Assume you are organizing your code something like 

```bash
home
└── github.com
    └── harikt
        ├── Aura.Router
        ├── Aura.Web
        └── monolog
```

Now on your project you could make use of the patches you are working on 
the local directory without pushing it to github.

> Note : You should commit the changes though.

```json
{
    "minimum-stability":"dev",
    "repositories": [
        {
            "type": "vcs",
            "url": "/var/www/github.com/harikt/monolog"            
        }
    ],
    "require": {
        "monolog/monolog": "dev-bugfix"
    }
}
```

And you can also disable packagist for fast look up.

## Experimenting your own packages

I did add packages in [packagist](https://packagist.org) for testing.
This is really a wrong way to do, you are adding more packages that 
makes other people's life hard to find a useful package.

What I learned is, you can do in a different way. See docs under 
[Package](https://getcomposer.org/doc/05-repositories.md#package-2)

So your `composer.json` will look something like this.

```json
{
    "minimum-stability":"dev",
    "repositories": [        
        {
            "type": "package",
            "package": {
                "name": "harikt/experiments",
                "version": "3.1.7",               
                "source": {
                    "type": "git",
                    "url": "/var/www/github.com/harikt/experiments",
                    "reference": "master"
                },
                "autoload": {
                    "classmap": ["libs/"]
                }
            }
        }
    ],
    "require": {        
        "harikt/experiments": "3.1.*"
    }
}
```

That's for now.

Happy PhPing!
