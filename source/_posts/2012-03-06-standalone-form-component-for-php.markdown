---
layout: post
title: Standalone Form component for PHP
categories: [forms, php, symfony2, zf2]
published: true
date: 2012-03-06 22:18
---

Update : I wrote an article on [Standalone Forms and Validation](http://harikt.com/blog/2013/05/21/standalone-forms-and-validation/)

Recently I was reading the post [Symfony2 Form Architecture][] by
[Bernhard Schussek][] . The main aim of his post was to make use of
Symfony2 form component in Zend Framework 2 as the form architecture
which was written in [RFC][] seems almost the same. This is a small
feedback I would love to give as I am interested to make the Form as a
standalone component, what ever framework we are using.

These all started with probably @fabpot tweets about it .

  [Symfony2 Form Architecture]: http://webmozarts.com/2012/03/06/symfony2-form-architecture/
  [Bernhard Schussek]: https://twitter.com/#!/webmozart
  [RFC]: http://framework.zend.com/wiki/display/ZFDEV2/RFC+-+Forms

> Is it just me or is the [\#ZF2][] form RFC heavily inspired by
> [\#Symfony2][]? /cc @[webmozart][]
> [framework.zend.com/wiki/display/Z…][]
>
> — Fabien Potencier (@fabpot) [February 27, 2012][]

<script src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
 

  [\#ZF2]: https://twitter.com/search/%2523ZF2
  [\#Symfony2]: https://twitter.com/search/%2523Symfony2
  [webmozart]: https://twitter.com/webmozart
  [framework.zend.com/wiki/display/Z…]: http://t.co/cRf01a3X
    "http://framework.zend.com/wiki/display/ZFDEV2/RFC+-+Forms"
  [February 27, 2012]: https://twitter.com/fabpot/status/174153351372611584
  
Some months back as of Symfony2 stable was released I tried to
incorporate the Form component to [Aura Project for PHP][] which was
aiming for 5.3 at that time. But now looking forward to 5.4 + only

Let have a look into the Symfony2 dependencies for Form component which
is described in pear.symfony.com 

EventDispatcher, Validator, Locale .

AuraPHP already have a Signal / Slot / Event Handler , so it doesn't
need the EventDispatcher, like the same ZF2 already have one, so I
feel EventDispatcher is not needed for both the frameworks. Lets don't
think what we have, lets see whether adding these components
really solve in creating to make it as a standalone component ?

<p>
<script src="http://pastie.org/2954729.js"></script>
</p>

  [Aura Project for PHP]: https://github.com/auraphp
  
[![Sf2Form][]][]

I have taken a screenshot of the tweets I got in reply. Thanks to all
who tried to help me .Below is the link to the details, and I hope you
can go more detailed on the tweets if needed.

  [Sf2Form]: http://farm8.staticflickr.com/7055/6813319456_3441d6be49.jpg
  [![Sf2Form][]]: http://www.flickr.com/photos/harikt/6813319456/
    "Sf2Form by K T Hari, on Flickr"
    
> @[harikt][] You don't need Twig. Simply the Twig form rendering is
> easier to get standalone. the PHP one is in the bundle @[weaverryan][]
> @[fabpot][]
>
> — Christophe Coevoet (@Stof70) [December 2, 2011][]

<script src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

So what is missing for Symfony2 form component ? It needs more
components as shown in the gist  below

  [harikt]: https://twitter.com/harikt
  [weaverryan]: https://twitter.com/weaverryan
  [fabpot]: https://twitter.com/fabpot
  [December 2, 2011]: https://twitter.com/Stof70/status/142643884047089664
  
<p>
<script src="https://gist.github.com/1170166.js"> </script>
</p>
So to conclude though the Symfony2 Form mentions as a standalone, its
not a standalone component at-least looking from a user point of view
like me. You can see various people asking about how to use Symfony2
Form component as a standalone in [google groups][]. But what people
points is to Silex again build on the shoulder of Symfony2 component . I
am not against Symfony2 , please don't feel so. But I just want to bring
the fact that, than writing a big architecture, people would be looking
how we can integrate it as standalone .

  [google groups]: https://groups.google.com/forum/?fromgroups#!topic/symfony-users/aAqDJjkl2gQ
  
So in my view I am looking forward to see how ZF2 will make a change
from Symfony2 or will it be the same like binding everything . I am also
looking forward to see how [Aura project for PHP 5.4][] can bring Form .
I have limited knowledge, so I may be wrong on the above things too.
Feel free to correct me

I am looking for something like the one below, yes of-course we need
validation and stuffs , but it will be standalone , no matter :-) .

  [Aura project for PHP 5.4]: http://auraphp.github.com

```php
<?php
//PFBC 2.x PHP 5 >= 5.3     
session_start();     
include($_SERVER["DOCUMENT_ROOT"] . "/PFBC/Form.php");
$form = new PFBC\Form("GettingStarted", 300);
$form->addElement(new PFBC\Element\Textbox("My Textbox:", "MyTextbox"));
$form->addElement(new PFBC\Element\Select(
    "My Select:",
    "MySelect",
    array(
        "Option #1",
        "Option #2",
        "Option #3"
    )
));
$form->addElement(new PFBC\Element\Button);
$form->render();

//PFBC 2.x PHP 5
session_start();
include($_SERVER["DOCUMENT_ROOT"] . "/PFBC/Form.php");
$form = new Form("GettingStarted", 300);
$form->addElement(new Element_Textbox("My Textbox:", "MyTextbox"));
$form->addElement(new Element_Select(
    "My Select:", 
    "MySelect", 
    array(        
        "Option #1",        
        "Option #2",        
        "Option #3"     
    )
));     
$form->addElement(new Element_Button);
$form->render();
```

An example where I can show such a standalone one is
http://code.google.com/p/php-form-builder-class/ . Currently to render
the form either you need [TwigBridge][] or [FrameworkBundle][] .

> @[harikt][] There is 2 implementations: TwigBridge and in
> FrameworkBundle but you could write one for Aura.View /cc
> @[webmozart][]
>
> — Christophe Coevoet (@Stof70) [March 6, 2012][]

<script src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

  [TwigBridge]: https://github.com/symfony/TwigBridge
  [FrameworkBundle]: https://github.com/symfony/FrameworkBundle
  [harikt]: https://twitter.com/harikt
  [webmozart]: https://twitter.com/webmozart
  [March 6, 2012]: https://twitter.com/Stof70/status/177148060881788929
  
If you are using Framework bundle you need [Templating component][] and
to my understanding if you are using TwigBundle you need Twig itself .
So is this a standalone ? Also if its really a standalone why it didn't
find a documentation as in
http://symfony.com/doc/current/components/index.html . The Symfony2 has
released months back, so I don't feel Symfony2 form is a standalone in
the sense as I shown in the example .

  [Templating component]: https://github.com/symfony/FrameworkBundle/blob/master/Templating/Helper/FormHelper.php
