---
layout: post
title: MongoDB and PHP by Steve Francia; O'Reilly Media
categories: [mongodb, php, O'Reilly]
published: true
date: 2012-02-13 21:30
---
I have already have read the book
[MongoDB: The Definitive Guide](http://shop.oreilly.com/product/0636920001096.do)
by Kristina Chodorow and Michael Dirolf .
It doesn't cover much on the PHP, but its a good book to learn
about MongoDB and how it works in Depth. Once I saw the book,
[MongoDB and PHP](http://shop.oreilly.com/product/0636920022381.do) by
Steve Francia I was planning to buy it, and the time I got a chance
to signup for the blogger review program by O'Reilly Media. Its a
small book of 60 pages, but a good one. I will rate 7.5 / 10 , a
good read for PHP Developers . If you wondered why the 2.5 is missing
read on  I have little experience playing with MongoDB and
[Lithium framework](http://li3.me) . I loved to give an 8 / 10 for the
book really . But the reason why I didn't gave is as its a small book
with 61 pages, its really a good way to include installation of
MongoDb in atleast one Operating System ( Ubuntu preferred ) .
As its not a big pain to install MongoDb in ubuntu its really a good
thing. The author Steve has been working with open sky and now with 10gen,
and has good experience with MongoDB and PHP.
He has presented it nicely, though there are some places need some more
clarifications for people new to MongoDB. Even I say its a 60 page book,
you cannot just read it in a 3 Hours if you really start playing with
it and understanding each and everything .  Some questions I felt in
reading page 26 is "If you want to retrieve only the slice itself
and not the entire document, you can come pretty close by retrieving the
_id and the slice" with the example

```php
print_r($addresses->findone(
    array( 'first_name' => 'Peter', 'last_name' => 'Parker'),
    array('_id' => 1, 'superpowers' => array('$slice' => 2)))
);
```

The above will give you

```php
Array(
    [_id] => MongoId Object(
        [$id] => 4f2e1b9caa6a477739000000
    )
    [superpowers] => Array(
        [0] => agility
        [1] => stamina
    )
)
```

The above was the only example, but I was thinking something more .
What will happen when _id is set to 0 like

```php
print_r(
    $addresses->findone(
        array( 'first_name' => 'Peter', 'last_name' => 'Parker'),
        array('_id' => 0, 'superpowers' => array('$slice' => 2))
    )
);
```

it returns

```php
Array(
    [address] => 175 Fifth Ave
    [city] => New York
    [first_name] => Peter
    [last_name] => Parker
    [state] => NY
    [superpowers] => Array(
        [0] => agility
        [1] => stamina
    )
    [zip] => 10010
)
```

and what about _id when removed like

```php
print_r(
    $addresses->findone(
        array('first_name' => 'Peter', 'last_name' => 'Parker'),
        array('superpowers' => array('$slice' => 2))
    )
);
```

will return

```php
Array(
    [_id] => MongoId Object(
        [$id] => 4f2e1b9caa6a477739000000
    )
    [address] => 175 Fifth Ave
    [city] => New York
    [first_name] => Peter
    [last_name] => Parker
    [state] => NY
    [superpowers] => Array(
        [0] => agility
        [1] => stamina
    )
    [zip] => 10010
)
```

Somethings like this are left to user to think why its so ?
Some example like 'Clark Kent' was never created, nor I remember whether
he mentios to create new ones. It would have been a good idea to
mention to insert new ones as the book teaches how to do it. The
other one which confuses me about Indexing , ie whether I want to run
the method ensureindex each and every time or only once
Eg : `$db->numbers->ensureindex(array( 'num' => 1 ));`  .

But once you finish reading the book carefully, you will definitely
can use MongoDB for your next project . He covers different types of
ODM for MongoDB. For further information look into
the product page at http://shop.oreilly.com/product/0636920022381.do   
