---
title: "Symfony Debug to Error Handler Component"
date: 2019-11-29T01:04:31+05:30
---

Since symfony 4.4 the `symfony/debug` component is deprecated.

> The "\Symfony\Component\Debug\ErrorHandler" class is deprecated since Symfony 4.4, use "\Symfony\Component\ErrorHandler\ErrorHandler"

Running unit tests on [Mascot](https://github.com/MascotPhp/Mascot/blob/70b41240a5db8a84d0e8aa57995fded21052b9e4/src/ExceptionHandler.php#L37-L44),
I noticed lots of warnings.

But it was not easy as changing `Symfony\Component\Debug\ExceptionHandler` to `Symfony\Component\ErrorHandler\ErrorHandler`.

Assume we have something as below

```php {linenos=table,hl_lines=[1,6],linenostart=37}
<?php
$handler = new \Symfony\Component\Debug\ExceptionHandler($debug);
$exception = $event->getThrowable();
if (!$exception instanceof FlattenException) {
    $exception = FlattenException::create($exception);
}
$response = Response::create($handler->getHtml($exception), $exception->getStatusCode(), $exception->getHeaders())->setCharset(ini_get('default_charset'));
$event->setResponse($response);
```

The `Symfony\Component\ErrorHandler\ErrorHandler` has no `getHtml` method.

From the symfony docs, if you are in development mode we can use below code.

```php
<?php
if ($_SERVER['APP_DEBUG']) {
    Debug::enable();
}
```

so I started with 

```php
<?php
ErrorHandler::register();
```

But it was throwing all details. I was struggling how to fix this. 
After many failed experiments, I asked [Yonel Ceruto Gonzalez](https://twitter.com/YonelCerutoG).

> Sets the scope at 0 to tell the handler that it is in "non-debug" mode: 
>
>   $errorHandler->scopeAt(0, true);
>
> However, don't expect the real exception message in non-debug mode, it could reveal sensitive information.
>
> — <cite>Yonel Ceruto Gonzalez[^1]</cite>

[^1]: Taken from twitter status [Yonel Ceruto Gonzalez](https://twitter.com/YonelCerutoG/status/1199767714035912704)

The above information was really helpful to do more experiments. I finally fixed the unit tests with the below code.

```php {linenos=table,hl_lines=[3,5,"8-10",14],linenostart=37}
<?php
$handler = new \Symfony\Component\ErrorHandler\ErrorHandler();
$handler->setExceptionHandler([$handler, 'renderException']);
if (! $this->debug) {
    $handler->scopeAt(0, true);
}
$exception = $event->getThrowable();
ob_start();
$handler->handleException($exception);
$response = ob_get_clean();
if (!$exception instanceof FlattenException) {
    $exception = FlattenException::create($exception);
}
$response = Response::create($response, $exception->getStatusCode(), $exception->getHeaders())->setCharset(ini_get('default_charset'));
```

I hope this information may help someone at somepoint of time.