---
layout: post
title: "Zend Feed and Guzzle"
date: 2015-04-01 12:15:39 +0530
comments: true
categories: [guzzle, zf2, feed]
---

You may have worked with Zend Feed as a standalone component.
I don't know whether you have integrated Zend framework Feed with Guzzle
as Http Client.

This post is inspired by [Matthew Weier O'Phinney](http://mwop.net),
who have mentioned the same on github.

Our `composer.json` looks

```json
{
    "require": {
        "guzzlehttp/guzzle": "~5.2",
        "zendframework/zend-feed": "~2.3",
        "zendframework/zend-servicemanager": "~2.3"
    },
    "autoload": {
        "psr-0": {
            "": "src/"
        }
    }
}
```

`Zen\Feed\Reader\Reader` have a method `importRemoteFeed` which accepts
an instance of `Zend\Feed\Reader\Http\ClientInterface`.

The `Zend\Feed\Reader\Http\ClientInterface` have only one method `get`
which returns `Zend\Feed\Reader\Http\ResponseInterface`.

So any http client that satisfy the interface will work. Let's create
them.

```php
<?php
// src/GuzzleClient.php
use GuzzleHttp\Client;
use Zend\Feed\Reader\Http\ClientInterface;

class GuzzleClient implements ClientInterface
{
    protected $guzzle;

    public function __construct(Client $guzzle)
    {
        $this->guzzle = $guzzle;
    }

    public function get($uri)
    {
        $response  = $this->guzzle->get($uri);
        return new GuzzleResponse($response);
    }
}
```

```php
<?php
// src/GuzzleResponse.php
use GuzzleHttp\Client;
use GuzzleHttp\Message\Response;
use Zend\Feed\Reader\Http\ClientInterface;
use Zend\Feed\Reader\Http\ResponseInterface;
use Zend\Feed\Reader\Reader;

class GuzzleResponse implements ResponseInterface
{
    protected $response;

    public function __construct(Response $response)
    {
        $this->response = $response;
    }

    public function getStatusCode()
    {
        return $this->response->getStatusCode();
    }

    public function getBody()
    {
        return (string) $this->response->getBody();
    }
}
```

Wiring up,

```php
<?php
require __DIR__ . '/vendor/autoload.php';

use GuzzleHttp\Client;
use Zend\Feed\Reader\Reader as FeedReader;

$client = new GuzzleClient(new Client());
$feed = FeedReader::importRemoteFeed('http://feeds.feedburner.com/harikt/YKAJ', $client);

echo 'The feed contains ' . $feed->count() . ' entries.' . "\n\n";
foreach ($feed as $entry) {
    echo 'Title: ' . $entry->getTitle() . "\n";
    // echo 'Description: ' . $entry->getDescription() . "\n";
    echo 'URL: ' . $entry->getLink() . "\n\n";
}
```

You can run from the command line.

Once [PSR-7](https://github.com/php-fig/fig-standards/blob/master/proposed/http-message.md)
is accepted, and if both guzzle and zend framework (zf3) is
built on top of it, we may not need to do the same.

Happy PhPing.
