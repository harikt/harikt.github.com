+++
title = "eloquent and pagination inside zend expressive"
date = "2015-11-13"
slug = "2015/11/13/eloquent-and-pagination-inside-zend-expressive"
Categories = []
+++

Recently working with eloquent (Laravel's orm), zend expressive and zend view,
I wanted to integrate pagination.

It was simple as registering a `Paginator` middleware.

```php
use Illuminate\Pagination\Paginator;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;

IlluminatePaginator::currentPageResolver(function ($pageName) use ($request) {
    $params = $request->getQueryParams();
    return empty($params[$pageName]) ? 1 : $params[$pageName];
});
IlluminatePaginator::currentPathResolver(function () use ($request) {
    return $request->getUri()->getPath();
});
```

and you can call paginate on the `Model`.

Eg : Consider you have a `Post` model.

```php
$posts = Post::paginate(20);
```

and in view you can iterate through the `$posts` and render the pagination.
The `$posts` is an object of [LengthAwarePaginator](http://laravel.com/api/5.0/Illuminate/Pagination/LengthAwarePaginator.html).

You can also modify the presenter accordingly. Default comes with  [BootstrapThreePresenter](http://laravel.com/api/5.0/Illuminate/Pagination/BootstrapThreePresenter.html)


```php
<?php
foreach ($this->posts as $post) {
?>
    <?= $post->title . "<br />" ?>
<?php
}
?>
<?= $this->posts->render() ?>
```

> Note : Please be aware of the [issues/10909](https://github.com/laravel/framework/issues/10909).
