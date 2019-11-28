+++
title = "thoughts on package or component"
date = "2013-01-04"
slug = "2013/01/04/thoughts-on-package-or-component"
Categories = []
+++

Comparing a software X with Y will not make anything worst, but makes it better. But many of them will think it as a promotional stuff. It is not anyones's problem. Some like to build it that way, some like the other way.

So I am not comparing X with Y here.

Not talking about package like Guzzle:

I am not mentioning building something like Guzzle, which is a framework that includes the tools needed to create a robust web service client.

But I am interested in talking about the packages which can be used to build something like Guzzle when you look into the require of composer.json.

That means something like Aura.Http which can be used to make a request to google and do the search if needed or post etc.

Structure of Package or Component:

1 ) We need to name a package. 

Let us go for the [PSR-0](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md) naming. 

Each namespace must have a top-level namespace ("Vendor Name"), and a Package name. Probably you will end up with Vendor.Package or Vendor_Package .

2 ) [Composer](http://getcomposer.org/)/[Eath](https://github.com/crodas/Eath), are great tools which help you to manage the dependency management in your PHP projects. So we need a composer.json or package.yml .

3 ) We are creating a package or component, so obviously it will contain source files and test files. It will be a mess when we keep all tests and source files in a same place. Most of them uses either `src` folder or `lib` or `library` to keep source files and `tests` to keep test files. Probably you have some documentation, a `docs` folder may help. May be some executable scripts. You can also add a `scripts` or `bin` folder.

Now your structure will be something like

```bash
Vendor.Package
  ├── composer.json
  ├── package.yml
  ├── docs
  ├── src
  │   └── Vendor
  │       └── Package
  └── tests
      └── Vendor
          └── Package
```
          
The above structure follows a PSR-0 naming convention for package/component.

NIH : We all create new packages for we don't like some other package invented here, not for its not invented here or probably to make use of newer stuffs like traits, closures etc available in PHP 5.4 than sticking with PHP 5 or sometimes it is not inveneted here.

So add your depenedencies to composer.json or package.yml

Let us assume we are going to create a Validation pacakge. Probably you love annotations or yml format. It is always a better idea to keep the annotations, yaml etc on a bridge than in the Validation package. Remember you have composer, let the bridge package composer.json helps you to download validation package, annotation library. This also helps you to write your integration tests in bridge package than making a dependency on the Validation package.

And also help people to use different annotations library than a single one or you will end up messing with more annotation classes.

I guess this helps people to 

1 ) fork and contribute

2 ) Even if there is no documentation, it helps to look into the source and get the point. Else a lot of classes confuses people.

Nothing is developed to make it bad, everything is made for good. Though at-times it acts badly.

These are some of the principles I learned looking at various projects like Aura, Symfony2, ZF2, Lithium, Fuel2, Illuminate... you name it.
