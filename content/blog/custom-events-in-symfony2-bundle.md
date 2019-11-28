+++
title = "custom events in symfony2 bundle"
date = "2015-10-11"
slug = "2015/10/11/custom-events-in-symfony2-bundle"
Categories = []
+++

In this tutorial we will create a custom event for symfony2 bundle. 

> Assuming you have downloaded the symfony-standard distribution to play.

Create `HktEventBundle` via [sensio generator bundle](http://symfony.com/doc/current/bundles/SensioGeneratorBundle/index.html).

```php
php app/console generate:bundle --namespace=Hkt/EventBundle --dir src --no-interaction
```

Create the event class.

```php
<?php
// src/Hkt/EventBundle/Event/PageViewed.php
namespace Hkt\EventBundle\Event;

use Symfony\Component\EventDispatcher\Event;

class PageViewed extends Event
{
    protected $name;

    public function __construct($name)
    {
        $this->name = $name;
    }

    public function getName()
    {
        return $this->name;
    }
}
```

Add as many methods/properties which are needed from the listener. Instead of 
creating an event class we can make use of [generic event](http://symfony.com/doc/current/components/event_dispatcher/generic_event.html) also.

## Dispatching Event

```
<?php
//src/Hkt/EventBundle/Controller/DefaultController.php
namespace Hkt\EventBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Hkt\EventBundle\Event\PageViewed;

class DefaultController extends Controller
{
    /**
     * @Route("/hello/{name}")
     * @Template()
     */
    public function indexAction($name)
    {
        $event = new PageViewed($name);
        $this->get('event_dispatcher')->dispatch('hkt.event.page_viewed', $event);
        return array('name' => $name);
    }
} 
```

## Listener

Create the listener to do what you want to do with the dispatched/triggered event.

```php 
<?php
// src/Hkt/EventBundle/EventListener/PageViewedListener.php
namespace Hkt\EventBundle\EventListener;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Hkt\EventBundle\Event\PageViewed;

class PageViewedListener implements EventSubscriberInterface
{
    public static function getSubscribedEvents()
    {
        return array(
            'hkt.event.page_viewed' => 'handler',
        );
    }

    public function handler(PageViewed $event)
    {
        // $event->getName();
        // do what you want with the event
    }
}
```

In order to get the `PageViewedListener` to be called, we need to register the listener to the `event_dispatcher`.

Add the below lines in `services.yml` or `services.xml` accordingly.

```yml
# src/Hkt/EventBundle/Resources/config/services.yml
hkt.event.page_viewed:
    class: Hkt\EventBundle\EventListener\PageViewedListener
Tags = [