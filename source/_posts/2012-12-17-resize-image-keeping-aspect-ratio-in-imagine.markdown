---
layout: post
title: "Resize image keeping aspect ratio in Imagine"
date: 2012-12-17 22:24
comments: true
categories: [imagine, php, resize]
---

I was working with Imagine recently. I want to create a standard width and height for the image that is created. Eg: 500 X 300 .

The user will be uploading different size images and I want to resize the image to X width and Y height. I was using imagine and the code helps to make this happen filling the blank space with white color without loosing aspect ratio.

```php resize image with imagine
<?php
$source = 'image.jpeg';
$destination = 'resize.jpg';
$width  = 300;
$height = 500;

$imagine   = new Imagine\Gd\Imagine();
$size      = new Imagine\Image\Box($width, $height);
$mode      = Imagine\Image\ImageInterface::THUMBNAIL_INSET;
$resizeimg = $imagine->open($source)
                ->thumbnail($size, $mode);
$sizeR     = $resizeimg->getSize();
$widthR    = $sizeR->getWidth();
$heightR   = $sizeR->getHeight();

$preserve  = $imagine->create($size);
$startX = $startY = 0;
if ( $widthR < $width ) {
    $startX = ( $width - $widthR ) / 2;
}
if ( $heightR < $height ) {
    $startY = ( $height - $heightR ) / 2;
}
$preserve->paste($resizeimg, new Imagine\Image\Point($startX, $startY))
    ->save($destination);
```

A normal image of size 500 X 500

{% img center /assets/images/kitten.jpg 500 500 'A cute kitten' 'a kitten' %}

when resized to 300 X 200

{% img center /assets/images/resize-image300x200.jpg 300 200 'Image resized to 300X200' 'resized image' %}

and 300 X 400

{% img center /assets/images/resize-image300x400.jpg 300 400 'Image resized to 300X400' 'resized image' %}

A huge Thanks to the person who helped me on Symfony2 irc to find the different modes. I am not recalling the irc handle currently. I will update once I remember the same.

Image courtsey [http://placekitten.com/](http://placekitten.com/)
