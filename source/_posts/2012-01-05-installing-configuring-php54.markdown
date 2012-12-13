---
layout: post
title: Installing and configuring PHP 5.4
tags: [php54, installing, php, compiling]
published: true
date: 2012-01-05 22:33
---
May be you already know Aura Project for PHP recently moved to 5.4. So I want to download PHP 5.4 and compiled. You need to download the development library files if you are seeing any errors. Just do via synaptic or apt-get. I did download apache2 and installed. Its not that much hard .  You can also run the tests, and report the errors to QA, which will help us. But I was facing a problem. Normally the php cli will be in /usr/bin/php . But in our case , it will be in /usr/local/bin/php . I was getting error when trying to execute phpunit and many pear packages. So the way you can do is to symbolic link /usr/bin/php to /usr/local/bin/php .  If you want to run [multiple PHP versions of PHP like PHP 5.3 , 5.4](http://derickrethans.nl/multiple-php-version-setup.html) etc consider reading [Derick Rethans](http://derickrethans.nl/) post and use the script to do the work. A big Thanks to him for sharing it .   
