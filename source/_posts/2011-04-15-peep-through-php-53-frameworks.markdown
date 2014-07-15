---
layout: post
title: A peep through PHP 5.3 frameworks
categories: [php]
published: true
date: 2011-04-15 10:29
---

Keep in mind that I am a core developer of aura.

## Aura

Aura is an independent collection of standalone library for PHP.
You can download and plug into any framework or library and start using
in approximately 1-2 minutes.

The lead is [Paul M Jones](http://paul-m-jones.com) the author of
SolarPHP, Savant, Zend_View and Zend_Db components. An active member of
the [PHP-FIG](http://www.php-fig.org) who made his hands dirty with
[psr-1](http://www.php-fig.org/psr/psr-1/),
[psr-2](http://www.php-fig.org/psr/psr-2/) and 
[psr-4](http://www.php-fig.org/psr/psr-4/).

## Packages available :

[Dependency injection container](https://github.com/auraphp/Aura.Di)

[Authentication](https://github.com/auraphp/Aura.Auth)

[Cli](https://github.com/auraphp/Aura.Cli)

[Request and Response](https://github.com/auraphp/Aura.Web)

[Router](https://github.com/auraphp/Aura.Router)

[Sispatcher](https://github.com/auraphp/Aura.Dispatcher)

[Html](https://github.com/auraphp/Aura.Html)

[View](https://github.com/auraphp/Aura.View)

[Event handlers](https://github.com/auraphp/Aura.Signal)

[Validation](https://github.com/auraphp/Aura.Filter)

[Extended pdo](https://github.com/auraphp/Aura.Sql)

[Query builders](https://github.com/auraphp/Aura.SqlQuery)

[sql schema](https://github.com/auraphp/Aura.SqlSchema)

[Marshal](https://github.com/auraphp/Aura.Marshal)

[build and modify uri](https://github.com/auraphp/Aura.Uri)

[http](https://github.com/auraphp/Aura.Http)

[Internationalization](https://github.com/auraphp/Aura.Intl)

[Session](https://github.com/auraphp/Aura.Session)

[forms](https://github.com/auraphp/Aura.Input)

[includer](https://github.com/auraphp/Aura.Include)

### Framework

[Web_Project](https://github.com/auraphp/Aura.Web_Project) : A micro framework
which can be expanded to full stack.

[Cli_Project](https://github.com/auraphp/Aura.Web_Project) : Deals only with cli application.

[Framework_Project](https://github.com/auraphp/Aura.Framework_Project) combining
both the cli and the web framework.

Support : on IRC FreeNode #auraphp , [auraphp groups](http://groups.google.com/group/auraphp),
[stackoverflow](http://stackoverflow.com/tags/auraphp)

## Pros

* Build on top of components
* Using components in other projects will help not to learn another library
* Small and growing community, easy to reach core developers

## Cons

* Small community. Remember : Everything starts small, but later make a difference.

## Symfony2

Fabien Potencier is the man behind Symfony2, which have a big community.

## Pros

* Large community
* Component driven
* Support backed by Sensiolabs
* Conferences

## Cons

* Learning curve is a bit steep

Source code : [https://github.com/symfony/symfony](https://github.com/symfony/symfony)

Support : Group and IRC

## Zend

## Pros

* Supported by Zend
* Large community
* Conferences

## Cons

* Learning curve is a bit steep

Source : [https://github.com/zendframework/zf2](https://github.com/zendframework/zf2)


## Flow

Founded by the TYPO3 association, which was earlier named Flow3.

[http://flow.typo3.org/](http://flow.typo3.org/)

## Pros

* Supported by typo3
* Nice community

## Cons

* Monolythic
* CLA need to be signed to contribute to project
* Not in github

## Laravel

Founded by Taylor Otwell.

[https://github.com/laravel/framework](https://github.com/laravel/framework)

## Pros

* Nice community
* Conferences
* Easy to learn

## Cons

* Monolythic

> NB:. Even if it claims to be driven by components, the way my defnition
to component is not satisfied.
Eg : [routing](https://github.com/illuminate/routing/blob/1fe6974d945989a14b0916536a09806c926165f8/composer.json#L10)

## Lithium

Lithium a framework started in 2009 by Nate Abele (X lead developer of cakephp),
Gwoo (X project leader of cake php),
David Persson, Joel Perras and many others. 
The most interesting thing I loved in Lithium is the filter system.

Source : [https://github.com/UnionOfRAD/framework](https://github.com/UnionOfRAD/framework)

Site : [http://li3.me](http://li3.me)

Support : #li3 on freenode

## Pros

* Nice community

## Cons

* Monolythic
* no stable version released
