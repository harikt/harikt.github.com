---
layout: post
title: "Seriously? Tab Vs Spaces"
date: 2013-02-27 07:38
comments: true
categories: [spaces, tabs]
---

I have created a repo [seriously][], and have [3 commits][] as of now .

[seriously]: https://github.com/harikt/seriosuly
[3 commits]: https://github.com/harikt/seriosuly/commits/master

It has a file [hell.php][]. I have created it by logging into `user X` 
and with vim as the editor without any settings in .vimrc.

{% img center /assets/images/vim-tab.png 'vim with no settings, and used tab' 'vim with no settings, and used tab' %}

[hell.php]: https://github.com/harikt/seriosuly/blob/master/hell.php

Then from user `harikt` I have edited with vim which has some .vimrc 
setting like 1 tab = 4 spaces. Look into the [code][] and see how beautiful 
it is.

Opening with geany it looks 

{% img center /assets/images/geany.png 'Oh from geany with settings 1 tab = 4 spaces' 'Oh from geany with settings 1 tab = 4 spaces' %}

[code]: https://github.com/harikt/seriosuly/blob/master/hell.php

Let us don't create problems, but solutions!

It is just one line you need to mention

"According to your editor settings set 1 tab = 4 spaces." . no?

Or you don't need to convert the tab at all? 

Is your tabs 4 spaces, 8 spaces, 2 spaces?

Please fork and commit with your favourite editor mentioning the settings, 
editor in your commit.

As as user I prefer consistency . And as I work with Aura, Symfony2, 
ZF1, ZF2 I love to follow spaces, than individual projects choosing their 
own styles which is a main benefit probably mostly to its users like me 
than the core developers of individual system who don't care about 
other projects or its users?

After all when your project says we use tabs, do you care people who love 
to use spaces there? Do you merge when something like this comes?
