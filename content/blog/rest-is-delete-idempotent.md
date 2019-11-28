+++
title = "rest is delete idempotent"
date = "2013-11-01"
slug = "2013/11/01/rest-is-delete-idempotent"
Categories = []
+++

This post is a thrive to learn, and not to show anyone is incorrect. 
Feel free to share your thoughts.

Lukas Kahwe Smith was having a nice post 
[RESTing with Symfony2](https://blog.liip.ch/archive/2013/10/28/resting-with-symfony2.html)

Quoting a few words from the post on REST

## DELETE and 404

> I started my talk on RESTing with Symfony2 with an introduction to REST itself. 
> On slide 7 of my talk I explained the concept of "safe" and 
> "idempotent" HTTP methods. Many people were surprised when I explained 
> that DELETE should be idempotent, meaning that sending a DELETE request 
> to a resource that has been removed should infact not return a 404.

I am not a REST guru, but in fact I got curious on the same, and 
was looking at http status [410 Gone](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.11)

> [@harikt](https://twitter.com/harikt) 1st Q that must be answered is if 
> DELETE is idempotent. if it is then the status code shouldn&#39;t 
> change on subsequent delete requests
> &mdash; Lukas Kahwe Smith (@lsmith) [October 29, 2013](https://twitter.com/lsmith/statuses/395160219376164864)

## What is idempotent?

Quoting from [Wikipedia](http://en.wikipedia.org/wiki/Idempotence)

> Idempotence is the property of certain operations in mathematics and 
> computer science, that can be applied multiple times without changing 
> the result beyond the initial application. The concept of idempotence 
> arises in a number of places in abstract algebra (in particular, in 
> the theory of projectors and closure operators) and functional 
> programming (in which it is connected to the property of referential transparency).

> There are several meanings of idempotence, depending on what the concept is applied to:

> * A unary operation (or function) is idempotent if, whenever it is applied twice to any value, it gives the same result as if it were applied once; i.e., ƒ(ƒ(x)) ≡ ƒ(x). For example, the absolute value: abs(abs(x)) ≡ abs(x).
> * A binary operation is idempotent if, whenever it is applied to two equal values, it gives that value as the result. For example, the operation giving the maximum value of two values is idempotent: max (x, x) ≡ x.
> * Given a binary operation, an idempotent element (or simply an idempotent) for the operation is a value for which the operation, when given that value for both of its operands, gives the value as the result. For example, the number 1 is an idempotent of multiplication: 1 × 1 = 1.

Christophe Coevoet also feel the same

> [@lsmith](https://twitter.com/lsmith) then 410 is probably the best status 
> code here, and 404 otherwise /cc [@harikt](https://twitter.com/harikt) [@_m6w6](https://twitter.com/_m6w6)
> &mdash; Christophe Coevoet (@Stof70) [October 29, 2013](https://twitter.com/Stof70/statuses/395193333347135488)

Why?

> [@lsmith](https://twitter.com/lsmith) The definition says &quot;without changing the result&quot;. 
> the HTTP spec says that the result is the state of the app [@_m6w6](https://twitter.com/_m6w6) [@harikt](https://twitter.com/harikt)
> &mdash; Christophe Coevoet (@Stof70) [October 29, 2013](https://twitter.com/Stof70/statuses/395193644585480192)

![ Status code of DELETE ](/assets/images/http-delete.png)

The above screenshot is limited, you can check all the messages passed from 
[https://twitter.com/harikt/status/395154834426314752](https://twitter.com/harikt/status/395154834426314752)

Woke up early morning and I noticed a subsequent post 
[Is a HTTP DELETE request idempotent?](http://www.duckheads.co.uk/is-a-http-delete-requests-idempotent/491)
by Lee Davis. Interesting to read his thoughts on the same.
There was a nice discussion by [Jason Lotito](http://www.jasonlotito.com/), 
do consider reading it.

I felt Jason Lotito is correct.

## Wikipedia has something to say aboout Idempotent methods 
[Hypertext Transfer Protocol Idempotent methods](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Idempotent_methods_and_web_applications)

> Methods PUT and DELETE are defined to be idempotent, meaning that multiple 
> identical requests should have the same effect as a single request 
> (Note that idempotence refers to the state of the system after the 
> request has completed, so while the action the server takes 
> (e.g. deleting a record) or the response code it returns may be 
> different on subsequent requests, the system state will be the same every time). 

So what does that mean?

Let us look into a real world example deleting http://example.com/post/121

We send a DELETE method via REST. What is going to happen?

I am quoting from 
[http://www.restapitutorial.com/lessons/httpmethods.html](http://www.restapitutorial.com/lessons/httpmethods.html)

> On successful deletion, return HTTP status 200 (OK) along with a response body, 
> perhaps the representation of the deleted item (often demands too much bandwidth), 
> or a wrapped response (see Return Values below). Either that or 
> return HTTP status 204 (NO CONTENT) with no response body

so far, so good.

What is going to happen on your subsequent request?

2nd time we are sending a DELETE method via REST, what do you expect to get?

[204 No Content](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.2.5). What does that mean?

> The server has fulfilled the request but does not need to return an 
> entity-body, and might want to return updated metainformation.

No Content is a good status, which means the server has exectuted your 
delete operation successfully is a wrong information.

iirc I have learned in Software Engineering, the wrong information 
is too bad than sending an error. Eg : 5+2 returning 9. I read some where 
at [http://www.joelonsoftware.com/](http://www.joelonsoftware.com/) the bug
they want to deal with when he was at microsoft. ( If anyone have the link
please comment it)

So if you know that a request for http://example.com/post/121 is already 
deleted, then [410 Gone](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.11)
will be the right status.

If you don't know [404 Not Found](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.5)
is the best status. Say it is not created, do we send 204?.

So here http://example.com/post/121 is already deleted.
(That means your subsequent response should be same, 
note that not response status code)

It is upto your application how to deal with making it truely RESTful. Else
passing false information as response always is a wrong way.

I have also tried to get RSDL (RESTful Service Description Language) 
[Maintainer](http://en.wikipedia.org/wiki/RSDL#Maintainer) to know 
the real information.

Probably I am wrong, but I am still learning REST.

Thank you.
