---
layout: post
title: Zend framework command line tools
categories: [zendframework]
published: true
date: 2009-08-15 22:07
---
I was trying the Zend framework . So these are some of the things that I have learned after the start .  Hope you have installed and configured Zend framework .Please do use some nice IDE's like the Eclipse PDT or Aptana or the Zend Studio . The IDE's are very helpful when you work on projects with zend framework . Please add the include path to Eclipse so it will automatically show the list of methods and members available . Also please do look the coding standards that every one is following especially the Zend .  1 ) Creating a project  \# zf create project mysite  \*mysite is the name of the project  2 ) Creating a controller  \# zf create controller user  \* user is the controller . You can use the small letters itself . The command line will add UserController class .  \# zf create action login user  \* login is the action , user is the controller .  So the code will produce loginAction method in the class UserController .  3 ) You can create a module for admin using  \# zf create module admin  4 ) Creating a controller for module  \# zf create controller add 1 admin  5 ) Creating an action for add controller in the admin module  \# zf create action blog add 1 admin  You can see help also . Just type zf will show you the all available options .   
