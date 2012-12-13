---
layout: post
title: Getting bored of seeing PHP as a templating language
tags: [templating, twig, mustache, dwoo, django, jinja, python, latte]
published: true
date: 2012-05-27 02:08
---
Are you also getting bored of seeing PHP as a templating language ? Why I started to love templating language like django . 

The index.html 

```html
{% extends "layout.html" %} {% block body %} {% for user in userlist %} {{ user.name }} {% elsefor %} **no user found** {% endfor %} {% endblock %} {% block title %}Index{% endblock %}
```

The layout.html

```html
{% block head %} {% block title %}{% endblock %} - My default title {% endblock %} {% block content %}{% endblock %} {% block footer %} © Copyright 2012 by [example.com](http://example.com/). {% endblock %} 
``` 
