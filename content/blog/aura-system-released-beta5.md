+++
title = "aura system released beta5"
date = "2013-05-25"
slug = "2013/05/25/aura-system-released-beta5"
Categories = []
+++

Yesterday Paul M Jones tagged the beta5 for the system repo.

So you can download the system from [http://auraphp.com/system/downloads/][]

via composer
------------

Creating aura framework based projects has been made easy with composer. You can run 
    
    php composer.phar create-project -s dev aura/system your-directory
    
What it does is almost similar to git clone and installing via git as below

via git
    
    git clone https://github.com/auraphp/system
    cd system
    php update.php
    
you can also skip php update.php with 
    
    php composer.phar install

You can read some basic introduction from [http://auraphp.com/system/][]

NB : If you haven't heard about composer you can read it from [getcomposer.org][]

[http://auraphp.com/system/]: http://auraphp.com/system
[http://auraphp.com/system/downloads/]: http://auraphp.com/system/downloads
[getcomposer.org]: http://getcomposer.org
