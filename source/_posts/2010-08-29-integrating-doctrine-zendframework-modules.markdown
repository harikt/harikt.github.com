---
layout: post
title: Integrating Doctrine with Zendframework for modules
categories: [php, zendframework, doctrine]
published: true
date: 2010-08-29 21:39
---
When I started learning PHP framework I started with [symfony-project](http://www.symfony-project.org/) . [Doctrine](http://www.doctrine-project.org) was one of the coolest feature I loved. So I thought of learning Doctrine to use with [Zend-framework](http://framework.zend.com/) . Recently I was looking  [zendcasts.com](http://zendcasts.com) to integrate doctrine with zend-framework . I think Jon didn't get much time to think about this solution else he may have come with the module based solution . But I was interested to provide how we can bring the doctrine models to different modules for zendframework. Use the below code in doctrine.php when using [zendcasts doctrine integration with zendframework](http://www.zendcasts.com/deep-integration-between-zend-and-doctrine-1-2/2010/01/) .  The way it works is  $./doctrine < arguments for doctrine \> module <module name \>  Module name is the zendframework module . If no module is specified or the specified module directory is not found , will create in the application/models folder . Else the models folder of the particular module. Assuming the migrations , schema.yml , fixtures etc are  there for each specific module :) .   
