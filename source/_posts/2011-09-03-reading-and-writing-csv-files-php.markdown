---
layout: post
title: Reading and Writing CSV files in PHP
categories: [php, csv]
published: true
date: 2011-09-03 14:07
---
PHP provides [fgetcsv](http://php.net/manual/en/function.fgetcsv.php) and [fputcsv](http://www.php.net/manual/en/function.fputcsv.php). But I was interested to use a PHP 5.3 library [Easy CSV](https://github.com/jwage/EasyCSV) by [Jonathan H. Wage](http://www.twitter.com/jwage), one of the core contributor of Doctrine Project , for the easiness to use .  I just copied some of the examples from the library for you. You can always look over https://github.com/jwage/EasyCSV and use it :) .  Reader :      $reader = new \EasyCSV\Reader('read.csv');     while ($row = $reader->getRow()) {         print_r($row);     }  Writer      $writer = new \EasyCSV\Writer('write.csv');     $writer->writeFromArray(array(             'value1, value2, value3',             array('value1', 'value2', 'value3')     ));   
