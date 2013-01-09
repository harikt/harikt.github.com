---
layout: post
title: Why you should write test
categories: [php, array_merge, union]
published: true
date: 2012-06-13 09:25
---
Recently I was reading [When to use array\_merge and union operator (+) in PHP?](http://sandeep.shetty.in/2012/05/when-to-use-arraymerge-and-union.html) . Lately working with examples I was also confused how the array\_merge and union works. Really, that brings a strong thought why you should write tests. Lets see some examples . {syntaxhighlighter class="php"} 'bar', 3, 4, '123' =\> 3); echo '$a = '; var\_export($a); $b = array('foo' =\> 'baz', 3, 6, 7, 3); echo PHP\_EOL . '$b = '; var\_export($b); echo PHP\_EOL . 'array\_merge( $a, $b) = '; var\_export( array\_merge($a, $b)); echo PHP\_EOL . '$a + $b = '; var\_export( $a + $b ); {/syntaxhighlighter} Do you have any thoughts on how the result for array\_merge and + comes? {syntaxhighlighter class="php"} $a = array ( 'foo' =\> 'bar', 0 =\> 3, 1 =\> 4, 123 =\> 3, ) $b = array ( 'foo' =\> 'baz', 0 =\> 3, 1 =\> 6, 2 =\> 7, 3 =\> 3, ) array\_merge( $a, $b) = array ( 'foo' =\> 'baz', 0 =\> 3, 1 =\> 4, 2 =\> 3, 3 =\> 3, 4 =\> 6, 5 =\> 7, 6 =\> 3, ) $a + $b = array ( 'foo' =\> 'bar', 0 =\> 3, 1 =\> 4, 123 =\> 3, 2 =\> 7, 3 =\> 3, ) {/syntaxhighlighter} Hope this makes to convince you also , why you should write tests :-) . A detailed post on the working is at http://unix0.wordpress.com/2012/01/08/php-array\_merge-vs-plus-union-operator/  
