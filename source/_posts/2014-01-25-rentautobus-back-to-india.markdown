---
layout: post
title: "Rentautobus back to India"
date: 2014-01-25 12:01:15 +0530
comments: true
categories: [rentautobus, travel, private chauffeur driven transport]
---

[Rentautobus.com](http://www.rentautobus.com) is a worldwide private 
transport quote comparison and reservations portal which was my first live project 
that made my hands dirty with [Zend Framework](http://framework.zend.com/).
I was hired as a maintainer for the multilingual website.

Multilingual websites when viewed from outside is not that complex. 
Before you dive into write your first line of code, everyone should read 
[The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](http://www.joelonsoftware.com/articles/Unicode.html)

Many of the developers don't care about the characterset and finally 
they see weird characters displayed and your client re-opening the same 
tickets. I don't blame any developers for until when you deal with something
like this you will end up in trouble.

## Tests!

How many of you really test your app?

Most of them, or the QA does it for you. Awesome!

But I am not talking about manual testing. 
Hope you have heard about automated testing tools like [phpunit](http://phpunit.de/). 
How many of you write unit tests? How does that help you?

Say you have the equation  (a+b)<sup>2</sup> = a<sup>2</sup> + 2ab + b<sup>2</sup>

What you do is write a simple class with the method which returns the result.

Everyone knows the expected result. But in most cases it may not be the same.
May be there is a new feature coming, if `a` is less than `b` use 

(a-b)<sup>2</sup> = a<sup>2</sup> - 2ab + b<sup>2</sup>

Now the complexity is increasing. And at somepoint of time you could not test
each one manually and unexpected results coming.

```php
<?php
class Algebra
{
    public function calculate($a, $b)
    {
        if ($a < $b) {
            $result = $a*$a + $b*$b - 2* $a*$b;
        } else {
            $result = $a*$a + $b*$b + 2* $a*$b;
        }
        return $result;
    }
}
```

In-order to get rid of the already tested one, writing unit tests is the
nice way. So the test will be something like

```php
<?php
class AlgebraTest extends PHPUnit_Framework_TestCase
{
    protected $algebra;

    public function setup()
    {
        $this->algebra = new Algebra();
    }

    /**
     * @dataProvider provider
     */
    public function testCalculate($a, $b, $result)
    {
        $this->assertEquals($result, $this->algebra->calculate($a, $b));
    }
    
    public function provider()
    {
        return array(
            array(3, 2, 25),
            array(2, 3, 25),
        );
    }
}
```

Here if you noticed what will happen when `a` and `b` are same?

What I am trying to point out is write tests, so the person who 
comes as a maintainer also can run the tests and see everything 
is working as expected.

Probably your client may blame you for taking more time, try to convience
them that it has saved `X` Hours to fix the bug!.

Be brave and start writing tests, for the next maintainer don't have to find 
whether it was a feature request or this is a bug.

> No one can learn everything in a single day, start small to achieve big.

## What rentautobus.com does?

The idea of rentautobus.com is to help both groups of people and 
individuals who are travelling to a different place/country to easily get quotes 
from private transport operators or travel agents. 
They can compare offers and quality, go through the reviews and feedback comments of people who have 
already travelled with these transport providers, how comfortable 
are they with the vehicle, the driver etc. The feedback system is not a 
new one, it's called `5 star rating` which is mostly used by travel and hotel websites.

In the promotional video below you can see the concept explained. 
This `comparison concept` is quite comon in Europe.

<iframe width="560" height="315" src="http://www.youtube.com/embed/zIirpcTgfhQ?rel=0" frameborder="0" allowfullscreen></iframe>

You can choose from a wide variety of travel agents, easily compare 
the price what they offer, the feedback they got from others. 
The 1st concept of the website was built for European countries like Spain. And  
as of today the site has expanded to other countries like India.

Rentautobus recently added 
[Car with Driver services in Cochin](http://www.rentautobus.com/en/india/kerala/kochi/car-rental-with-driver/item1306) 
to the list of countries, places and services offered.

## Will the concept in India work like Spain?

I'm curious to see if this European concept will have the same acceptance 
in [India](http://www.rentautobus.com/en/india/item1291) as in 
[Spain](http://www.rentautobus.com/en/spain/item48). 

Cultural differences do exist and this of-course translates into the 
use of internet as a research and booking tool for transport, tours or other travels. 
Travel arrangements in India by people over here are often done via a 
trusted travel agents who normally is a friend or introduced by a friend  
or family member.

For foreign tourists traveling to India for the 1st time, with no local 
contacts its of-course a good thing to have a friendly internet 
reservation tool for their transport arrangements.

We are not sure yet how the system should be adapted to fit the local Indian cultural requierments. 

Let us know your thought and opinions!
