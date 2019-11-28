+++
title = "frameworks are good"
date = "2014-01-09"
slug = "2014/01/09/frameworks-are-good"
Categories = []
+++

Some of the recent discussions in the PHP world are  

* [The Tribal Framework Mindset](http://philsturgeon.co.uk/blog/2014/01/the-tribal-framework-mindset)

* [Decoupling your packages from your framework](http://adamwathan.me/2014/01/05/decoupling-your-packages-from-your-framework)

* [You don’t need a framework](http://www.brandonsavage.net/you-dont-need-a-framework/) 

* [Frameworks for everyone](http://afilina.com/frameworks-for-everyone/)

## Framework is not a bad idea

If you don't use a framework, probably you will be using a bunch 
of independent libraries glued together or some code which 
help you to achieve your task.

Whether we use a framework or independent library, our ultimate aim 
is building the right product for our customer.

If you are building an app, and if you strongly feel symfony is the 
right choice you should go with it. And if you feel zend framework, 
auraphp, fuelphp, cake .. (you name it) is the right one you should go for it.

The ultimate aim of any framework developers is to make a living from 
it or to advertise his capability. So all will advertise it as good 
and never say a bad word even if they know the pit falls.

One of the recent problem we can notice is every php framework
tries to advertise they are developed from components.

## First

Laravel is an awesome framework, so do [symfony](http://symfony.com), 
[zend framework](http://framework.zend.com) and you name it.

> and not to your surprise "I love [auraphp](http://auraphp.com)"

## Don't call all are build from libraries

May be we need to define how/why we call it as library.

Consider a routing library : You give a URL path and `$_SERVER` values it extracts the route information.

Some of the libraries that does the work are 
[aura/router](https://packagist.org/packages/aura/router), 
[symfony/routing](https://packagist.org/packages/symfony/routing), 
[illuminate/routing](https://packagist.org/packages/illuminate/routing)

Apart from aura, I did a search for routing in [packagist](https://packagist.org/search/?q=routing)

If you have a good eye, you would have understood looking at the packagist 
dependencies.

The next one is regarding the `require-dev`. The `require-dev` dependency 
is when you want to bind other components.
The best way is to get rid of the `require-dev`. The glue package should 
be another independent package.

Consider [Lusitanian/PHPoAuthLib](https://github.com/Lusitanian/PHPoAuthLib/tree/e9160f45ee1a32d2087e1c792a1e1da131ac332e/src/OAuth/Common/Storage)
Symfony session has one. What will happen when someone who loves zend, aura, fuel etc 
love to have the session. It gets overly complicated.
So is https://github.com/friendsofaura/OAuthSession repo born.
Another good example I would like to show is 
[aura/project-kernel](https://packagist.org/packages/aura/project-kernel)

Yes it is a bit of hack, to run tests. Have a look into 
[travis](https://github.com/auraphp/Aura.Project_Kernel/blob/e8add743613f86147534b502145e2e3ef909f344/.travis.yml)

What I love to see in the PHP world is have a single repo where 
the pull request, create issues can be made rather than going and 
forking the entire code base. And not to mix the source and tests.

The [packagist](http://packagist.org/) need a way to sort 
dependent packages, independent packages and framework dependent packages.

If you are new to PHP, I will recommend you to use components and glue 
it together. 

* Start with a [routing library](https://github.com/auraphp/Aura.Router/tree/develop-2), 
see how [dispatching](https://github.com/auraphp/Aura.Router/tree/develop-2#dispatching-a-route) can be done.
* Try integrating a much better [dispatcher](https://github.com/auraphp/Aura.Dispatcher)
* Now your controller need 
[request](https://github.com/auraphp/Aura.Web/blob/develop-2/README-REQUEST.md)/
[response](https://github.com/auraphp/Aura.Web/blob/develop-2/README-RESPONSE.md).

Your application defnitely at some point of time need 
[Input Filtering & Validation](http://websec.io/2013/12/31/Input-Filtering-Validation-Aura-Filter.html)

May want to introduce [form libraries](http://harikt.com/phpform/) to glue with your legacy code.

You will learn PHP, and not the magic of a framework. 
Depending upon the dependencies it will be easy to replace the component.
That is the ultimate aim of components, not to trap you.

Thanks for reading.

Happy PhPing!
