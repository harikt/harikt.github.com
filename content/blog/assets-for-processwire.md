+++
title = "assets for processwire"
date = "2013-11-08"
slug = "2013/11/08/assets-for-processwire"
Categories = []
+++

[Processwire](http://processwire.com/) is a content management framework.

I was looking to change the directory structure of the Processwire.

```bash
|-- index.php
|-- installer.php
|-- README.md
|-- site
`-- wire
```

I am not the first person to talk on the subject. There are other threads 
like 
[Installation paths and moving folders](http://processwire.com/talk/topic/876-installation-paths-and-moving-folders/), 
[Common practices](http://processwire.com/talk/topic/3445-common-practices/)

Anyway I thought of trying the same and for serving the `js`, `css`, `images`
I wrote my first processwire module [Assets](https://github.com/harikt/Assets)

Some of the portions are from 
[Aura.Framework](https://github.com/auraphp/Aura.Framework/blob/f122f77b7f97d3bec9dbf930a66e706d2b89b6f8/src/Aura/Framework/Web/Asset/Page.php#L123-L147)
and [Aura.View](https://github.com/auraphp/Aura.View/blob/613286b1122bd7ef78a12550afdb10f78813d040/src/Aura/View/FormatTypes.php#L31-L113)

```bash
|-- cli
|-- composer.json
|-- index.php ( which is moved to web folder )
|-- installer.php
|-- README.md
|-- site
|   |-- assets
|   |-- config.php
|   |-- hello.css
|   |-- install
|   |-- modules
|   `-- templates
|-- vendor (3rd party vendors from PHP, Eg: Aura.Includer )
|-- httpdocs ( you can name this folder what ever you like )
|   |-- index.php
|   |-- site ( css, js and images copied from realpath )
|   `-- wire ( css, js and images copied from realpath )
`-- wire
    |-- config.php
    |-- core
    |-- index.config.php
    |-- modules
    |-- README.txt
    `-- templates-admin
```

You also need to change the `$rootPath` in `index.php` accordingly.
Hope someone will find it useful.
I am releasing it under [BSD-2-Clause](http://opensource.org/licenses/BSD-2-Clause)
