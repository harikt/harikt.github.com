---
layout: post
title: "CakePHP ORM and Illuminate Pagination"
date: 2016-01-13 20:27:46 +0530
comments: true
categories: [cakephp, illuminate, pagination]
---

Do you know CakePHP version 3 has a lovely ORM which can be used as standalone?

Thank you [José Lorenzo Rodríguez](https://github.com/lorenzo) and every contributor, for your hard work.

```
composer require cakephp/orm
```

That's it.

Working on I noticed I need to do some pagination. Oh, remember we have `illuminate/pagination`. Why not use it?

Problem, there seems no one have implemented it. How could we achieve it?
Lets do it.

```
composer require illuminate/pagination
```

If you are using a psr-7 request / response here is the middleware for you.

```php
<?php
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Illuminate\Pagination\Paginator as IlluminatePaginator;
class PaginatorMiddleware
{
    public function __invoke( ServerRequestInterface $request, ResponseInterface $response, callable $next = null )
    {
        IlluminatePaginator::currentPageResolver(function ( $pageName = 'page' ) use($request )
        {
            $params = $request->getQueryParams();
            return empty($params[$pageName]) ? 1 : $params[$pageName];
        });

        IlluminatePaginator::currentPathResolver(function () use($request )
        {
            return $request->getUri()->getPath();
        });

        return $next($request, $response);
    }
}
```

What we did above are a few things for Illuminate to give the url path when
it is doing the pagination. So for example `/article?page=<page-number>` will come
instead of just `?page=<page-number>`.

```php
<?php
use Cake\ORM\TableRegistry;
use Illuminate\Pagination\Paginator;
use Illuminate\Pagination\LengthAwarePaginator;

$table = TableRegistry::get('Articles');
$currentPage = 1;
$perPage = 20;
$query = $table->find('all');
$total = $query->count();
$items = $query->page($currentPage, $perPage);
$paginator = new LengthAwarePaginator($items, $total, $perPage, $currentPage, [
	'path' => Paginator::resolveCurrentPath(),
]);
echo $paginator->render();
```

The above code is querying the articles and rendering the pagination with the returned results.

By default the Presenter is `Illuminate\Pagination\BootstrapThreePresenter`, but you
can create your own.

I hope you will love the integration.

Thank you everyone for your support and hard work on components to make PHP better every day.
