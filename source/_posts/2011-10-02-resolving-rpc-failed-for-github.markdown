---
layout: post
title: Resolving RPC failed for github
categories: [github]
published: true
date: 2011-10-02 15:07
---
I was experiencing the error for sometime now. I had talked with people at github, and they have tried helping me but the solution was to for for git in the place for https . {syntaxhighlighter bash} hari@hari-Vostro1510:/media/Linux$ git clone https://github.com/ornicar/lichess.git Cloning into lichess... error: RPC failed; result=28, HTTP code = 0 fatal: The remote end hung up unexpectedly hari@hari-Vostro1510:/media/Linux$ git clone git://github.com/ornicar/lichess.git Cloning into lichess... remote: Counting objects: 43187, done. remote: Compressing objects: 100% (12728/12728), done. remote: Total 43187 (delta 25383), reused 42745 (delta 24955) Receiving objects: 100% (43187/43187), 6.04 MiB | 17 KiB/s, done. Resolving deltas: 100% (25383/25383), done. hari@hari-Vostro1510:/media/Linux$ {/syntaxhighlighter}  
