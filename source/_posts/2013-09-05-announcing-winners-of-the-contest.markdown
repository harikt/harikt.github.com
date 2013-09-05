---
layout: post
title: "Announcing winners of the contest"
date: 2013-09-05 20:25
comments: true
categories: [contest, winners, zf2]
---

A few days back I ran a contest to Win Free Copies of Packt’s New Book on 
[Zend Framework 2.0 by Example](http://harikt.com/blog/2013/08/23/chance-to-win-free-copies-of-packts-new-book-on-zend-framework-2-dot-0/).

So the lucky 3 are

* Nick Stanton
* Kristopher Wilson
* Dave Hall

You may be having a question how I choose the winners.

What I did is created the list of people in an excel sheet and ran 
the script.

```php
<?php
for ($i=0; $i < 3; $i++) {
    echo rand(1, 18) . PHP_EOL;
}
```

There were 19 people who participated in the contest. 
Dibin joseph was late and commented on Saturday August 31, 
as the contest ended on 30th August 2013.

You can guess, why I opted to run such a script. Many of them are
known to me, and I don't want to do any partiality.

Congrats to the winners and I hope you will find the book interesting.

Thanks to all for actively participating, tweeting and promoting the
contest.
