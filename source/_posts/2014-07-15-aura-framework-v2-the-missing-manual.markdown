---
layout: post
title: "Aura Framework v2: The missing manual"
date: 2014-07-15 10:17:29 +0530
comments: true
categories: [auraphp, manual, book, v2, leanpub, aurav2manual]
---

[Aura](http://auraphp.com) has an awesome collection of 
[libraries](https://github.com/auraphp) for different purpose.

It has components for 
[authentication](https://github.com/auraphp/Aura.Auth),
[cli](https://github.com/auraphp/Aura.Cli), 
[request and response](https://github.com/auraphp/Aura.Web), 
[router](https://github.com/auraphp/Aura.Router), 
[dependency injection container](https://github.com/auraphp/Aura.Router), 
[dispatcher](https://github.com/auraphp/Aura.Dispatcher), 
[html](https://github.com/auraphp/Aura.Html), 
[view](https://github.com/auraphp/Aura.View), 
[event handlers](https://github.com/auraphp/Aura.Signal), 
[validation](https://github.com/auraphp/Aura.Filter), 
[extended pdo](https://github.com/auraphp/Aura.Sql), 
[query builders](https://github.com/auraphp/Aura.SqlQuery), 
[sql schema](https://github.com/auraphp/Aura.SqlSchema), 
[marshal](https://github.com/auraphp/Aura.Marshal), 
[build and modify uri](https://github.com/auraphp/Aura.Uri), 
[http](https://github.com/auraphp/Aura.Http), 
[internationalization](https://github.com/auraphp/Aura.Intl), 
[session](https://github.com/auraphp/Aura.Session), 
[forms](https://github.com/auraphp/Aura.Input), 
[includer](https://github.com/auraphp/Aura.Include).

If you are new to aura, there is probably something you 
may want to figure out yourself.

Some of the components have [version 1](http://auraphp.com/packages/) and 
[version 2](http://auraphp.com/packages/v2) releases. 
There is a question of which branch corresponds to which version.

The v1 packages are in `develop` branch and v2 over `develop-2` branch.

There are a few changes in v1 to v2. It is easy to understand when you 
look into the `composer.json` or if you know aura 
v2 follows [psr-4](http://www.php-fig.org/psr/psr-4/) 
directory structure than the v1 that followed 
[psr-0](http://www.php-fig.org/psr/psr-0/).

If you see a package `"aura/installer-default": "1.0.0"` in the 
require of `composer.json` it is for sure v1.

Composer installs every package in the vendor folder. The 
name of the package installed will be the package name. So basically 
it installs `vendor/aura/<package-name>` .

In aura framework v1 we have some specific folder structure and it was 
before composer becomes a standard. So when composer became a standard
we added a way to install the framework specific installations in
`package` folder and the rest of the library installation (other than aura framework)
in the same way as composer did.

So was the existence of `aura/installer-default` in v1 package. In v2 we moved 
to [composer assisted two stage configuration](http://auraphp.com/blog/2014/04/07/two-stage-config/).

# v2 Framework

There exists a [micro framework/full stack](https://github.com/auraphp/Aura.Web_Project) 
framework for v2. But things are hard to find when you are 
new to aura and when [github organization](https://github.com/auraphp) 
have more than 30 repositories.

[Aura framework]((https://github.com/auraphp/Aura.Framework_Project) 
is built on top of aura libraries, and the library docs 
applies to the framework also. But people new to aura may be having
hard time to find the specific documentation or may be stuck sometime.
I don’t know whether my thoughts are right or wrong.

Documentation is one of the hardest problem when newer versions
are released. Say 1.0.0 released, 1.1.0 ... although the documentation 
is there in the installed repo, it is probably hard to make things online.

I was talking with [Paul M Jones](http://paul-m-jones.com/) 
regarding the documentation lately, 
and he too shared some concerns. Talking with him gave me some 
inspiration to start 
[the missing manual for the aura framework](http://leanpub.com/aurav2/read). 

## Goal 

* let people read and learn
* promote aura with good documentation
* at the sametime, to make a living

Yes, I am independent freelance php developer. It was a sad 
story that I don’t want to recall how I became a freelancer 
by chance. 

Before my freelancing, I was down for a few months, not physically 
but mentally which has impacted my life with some ups and downs. 
But now I really love working as an independent contractor.

## About the book

You can find the [book over github](http://github.com/harikt/aurav2book) 
licensed under 
[Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/deed.en_US)

The book is available [free to read online](https://leanpub.com/aurav2/read).
If you find a typo, or feel something can be improved 
[open an issue](https://github.com/harikt/aurav2book/issues)
or [send a pull request](https://help.github.com/articles/using-pull-requests) .

If you find it interesting you should consider 
[buying a copy from leanpub](https://leanpub.com/aurav2/packages/book/purchases/new) 
to show your support to the project. 

Thank you.
