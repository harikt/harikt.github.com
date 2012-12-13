---
layout: post
title: Setting to run mysql query within aptana studio
tags: [aptana, database configuration]
published: true
date: 2009-07-06 21:24
---
These are the steps that are needed to make a database connection to run queries inside the aptana IDE .  Click the Database Perspective . Right click and add Database . Enter a name to recogise easy for you .  ( Picture below shows it )  ![First screen shot , how to run mysql queries inside aptana studio](http://farm4.static.flickr.com/3628/3694154069_10f353d8c5.jpg?v=0)  Clicking Next will ask you for the username and password and the connection string . The user name and password is that of your mysql db . Hope you have already installed MySQL .  ![Connection string for aptana studio](http://farm3.static.flickr.com/2669/3694154075_ab66c55792.jpg?v=0)  The connection string is **jdbc://mysql://localhost:3036/**  when its ok you can test it and check whether it works fine .  Connecting to server is jdbc://mysql://www.domain.com:port/  I too have searched to find the solution . Got it from Aptana forum . The forum is great, so you don't need to worry about it .   
