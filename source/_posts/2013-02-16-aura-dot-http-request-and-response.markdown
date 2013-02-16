---
layout: post
title: "Aura.Http : Request and Response"
date: 2013-02-16 14:44
comments: true
categories: [php, auraphp]
---

The `Aura.Http` package provide you the tool to build and send request and response.

Instantiation:
==============

The easiest way is 

```php
$http = require 'path/to/Aura.Http/scripts/instance.php';
```

What it gives you is an object of `Aura\Http\Manager`. If you want to create 
manually you can look into the `instance.php`

Building your Response
======================

Probably you may not have bothered too much on building the http response 
either the framework does it for you, or until you need to send the correct
response.

To create a proper http response via `Aura.Http` we need to create a 
response object.

```php
$response = $http->newResponse();
```

Now you have the response object. You can set the `header` via 

```php
$response->headers->set('Header', 'Value');
```
If you have an array of headers you can use `setAll`

```php
$response->headers->setAll([
    'Header-One' => 'header one value',
    'Header-Two' => [
        'header two value A',
        'header two value B',
        'header two value C',
    ],
]);
```

So a basic example of setting header value is 

```php
$response->headers->set('Content-Type', 'text/plain');
```

Setting Content
---------------
The header values are for the browser to understand what is coming from 
server, and how it should render etc.

So we need to set the content. This can be achieved via `setContent` method.

```php
$response->setContent('<html><head><title></title></head><body>Hello World!</body></html>');
```

You can always get the content via calling `getContent`.

Setting and Getting Cookies
---------------------------
Sometimes we may want to set the cookies. You can do it as 

```php
$response->cookies->set('cookie_name', [
    'value'    => 'cookie value', // cookie value
    'expire'   => time() + 3600,  // expiration time in unix epoch seconds
    'path'     => '/path',        // server path for the cookie
    'domain'   => 'example.com',  // domain for the cookie
    'secure'   => false,          // send by ssl only?
    'httponly' => true,           // send by http/https only?
]);
```
The array keys mimic the [setcookie][] parameters. If you have an array 
you can use `setAll`.

```php
$response->cookies->setAll([
    'cookie_foo' => [
        'value' => 'value for cookie foo',
    ],
    'cookie_bar' => [
        'value' => 'value for cookie bar',
    ],
]);
```

You can get a cookie by calling `get` method on cookies.

```php
$response->cookies->get('cookie_name');
```

Setting and Getting Status
--------------------------

By default the status code is 200. But at some point of time 
like the one I explained earlier in [Status Code 304][], we don't need to 
send the whole content. But just the status code.

This is possible via `setStatusCode` and `setStatusText`

```php
$response->setStatusCode(304);
$response->setStatusText('Same As It Ever Was');
```

Sending your response
---------------------

And finally we can send the response back. We can call the `send` 
method and pass the `response` object.

```php
$http->send($response);
```

The full source code of example is

```php
$http = require 'path/to/Aura.Http/scripts/instance.php';
// send a response
$response = $http->newResponse();
$response->headers->set('Content-Type', 'text/plain');
$response->setContent('<html><head><title></title></head><body>Hello World!</body></html>');
$http->send($response);
```

From terminal start the server by `php -S localhost:8000 example.php` and 
pointintg to `localhost:8000` in your browser.

In order to render just `Hello World!` in the browser the `Content-Type` we added should be 
`text/html`.

We can always change the header status code, content-type etc 
before we call `send()` method.

Let us modify the example at [Status Code 304]

```php
$http = require 'path/to/Aura.Http/scripts/instance.php';
$response = $http->newResponse();
if ( isset($_SERVER['HTTP_IF_MODIFIED_SINCE']) && 
    $_SERVER['HTTP_IF_MODIFIED_SINCE'] == 'Tue, 15 Jan 2011 12:00 GMT' ) {
    $response->setStatusCode(304);
} else {
    $response->headers->set('Content-Type', 'text/html');
    $response->headers->set('Last-Modified', 'Tue, 15 Jan 2011 12:00 GMT');
    $response->setContent('<html><head><title></title></head><body>Hello World!</body></html>');
}
$http->send($response);
```

You would have noticed I have used `$_SERVER` variable. In `Aura.Http`, 
there is no methods to access the global server values. This is because
the `$_SERVER` values are not the exact http requested header. The server
modifies the request and we will be only getting the manipulated values 
if we use `$_SERVER`, `$_GET`, `$_POST` values.

`Aura.Http` only helps you to build, create, modify response and request.

Creating Http Request
=====================

We talked about response so far. What does Request actually mean?

Client -> Request something -> Server Responds

So that means we are trying to be a client or a browser, and making the necessary 
headers and sending to server to get the corresponding response.

We can get all the repos of a user in github via curl.

```
curl -i https://api.github.com/users/pmjones/repos
```

The same can be achieved via [Aura.Http][]. The [Aura.Http][] provides a 
means to do the same with PHP. It uses `curl` if it is available or `stream` 
to make this happen.

You need to create a Request object.

```php
$request = $http->newRequest();
```

Set the url via `setUrl` method and send.

```php
$request->setUrl('https://api.github.com/users/pmjones/repos');
$stack = $http->send($request);
$repos = json_decode($stack[0]->content);
foreach ($repos as $repo) {
    echo $repo->name . PHP_EOL;
}
```

There are more things to say. It can do basic authentication, post values etc. 
Browse the documentation examples, source code, tests, and api.

Source Code : [https://github.com/auraphp/Aura.Http][]

Documentation : [http://auraphp.github.com/Aura.Http/version/1.0.0/][]

API : [http://auraphp.github.com/Aura.Http/version/1.0.0/api/][]

[Content-Type]: http://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types
[setcookie]: http://php.net/setcookies
[Status Code 304]: http://harikt.com/blog/2012/12/16/status-code-304/
[Aura.Http]: https://github.com/auraphp/Aura.Http
[http://auraphp.github.com/Aura.Http/version/1.0.0/api/]: http://auraphp.github.com/Aura.Http/version/1.0.0/api/
[http://auraphp.github.com/Aura.Http/version/1.0.0/]: http://auraphp.github.com/Aura.Http/version/1.0.0/
[https://github.com/auraphp/Aura.Http]: https://github.com/auraphp/Aura.Http
