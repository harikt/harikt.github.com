---
layout: post
title: "Magento and REST api"
date: 2013-07-05 08:31
comments: true
categories: [magento, rest, zendframework]
---

Magento provides both REST and SOAP api. In this post I would like to 
concentrate on REST api to connect and get the products from magento shop.

First we want to register an Oauth consumer to get the consumer key and secret key.

Login to the admin of the magento shop and from the menu 
`System->Web Services->REST - Oauth Consumers` and add a new Ouath consumer.

![REST - Oauth Consumers](http://harikt.com/images/oauth-consumer.png)

You need the Key and Secret which is what we pass in the config to 
`Zend_Oauth_Consumer` shortly.

Let us also assign the right permissions for the attributes. From the menu 
`System->Web Services->REST - Attributes` click on Admin and assign the right 
permission. In our case we give access to products.

![REST - Attributes](http://harikt.com/images/magento_rest_attributes.png)

Now it is time to show you some code. In most case, we would have defined a
named route, and depeding upon your route in zend framework call the url.

Assuming the default url `http://localhost:8000/index/index` and accessing 
this in your browser will redirect you to the magento shop and get the access token after 
you authenticating and allowing it.

Note : Make sure that the domain you have logged in and the one 
you have provided in the callback url of magento REST Oauth consumer are 
same. Else you will find hard time debugging why session is lost.
(I am talking about the difference in http://www.example.com and http://example.com)

You want to change the below parameters in the controller according to yours.

`$this->hostname`: The magento shop

`$consumerKey`: The key you got when creating the oauth consumer

`$consumerSecret`: The secret key you got when creating the oauth consumer

`$callbackUrl`: The url where it will be redirected to get the accesstoken, 
same as the one you have provided when creating the oauth consumer.

Source Code
-----------

```
<?php
class IndexController extends Zend_Controller_Action
{
    public function init()
    {
        $this->hostname = 'the-magento-host';
        $consumerKey = '';
        $consumerSecret = '';
        $callbackUrl = 'callback-url';
        $this->config = array(
            'callbackUrl' => $callbackUrl,
            'requestTokenUrl' => $this->hostname . '/oauth/initiate',
            'siteUrl' => $this->hostname . '/oauth',
            'consumerKey' => $consumerKey,
            'consumerSecret' => $consumerSecret,
            'authorizeUrl' => $this->hostname . '/admin/oauth_authorize',
            // 'authorizeUrl' => $this->hostname . '/oauth/authorize',
            'accessTokenUrl' => $this->hostname . '/oauth/token'
        );
    }

    public function indexAction()
    {        
        $accesssession = new Zend_Session_Namespace('AccessToken');
        if (isset($accesssession->accessToken)) {
            $token = unserialize($accesssession->accessToken);            
            // $client = $token->getHttpClient($this->config);
            $client = new Zend_Http_Client();
            $adapter = new Zend_Http_Client_Adapter_Curl();
            $client->setAdapter($adapter);
            $adapter->setConfig(array(
                'adapter'   => 'Zend_Http_Client_Adapter_Curl',
                'curloptions' => array(CURLOPT_FOLLOWLOCATION => true),
            ));
            $client->setUri($this->hostname . '/api/rest/products');
            $client->setParameterGet('oauth_token', $token->getToken());
            $client->setParameterGet('oauth_token_secret', $token->getTokenSecret());
            $response = $client->request('GET');
            $products = Zend_Json::decode($response->getBody());
        } else {
            $consumer = new Zend_Oauth_Consumer($this->config);
            $token = $consumer->getRequestToken();
            $requestsession = new Zend_Session_Namespace('RequestToken');
            $requestsession->requestToken = serialize($token);
            $consumer->redirect();
        }
        $this->view->products = $products;
    }
    
    public function callbackAction()
    {
        $requestsession = new Zend_Session_Namespace('RequestToken');
        if (!empty($_GET) && isset($requestsession->requestToken)) {
            $accesssession = new Zend_Session_Namespace('AccessToken');
            $consumer = new Zend_Oauth_Consumer($this->config);
            $token = $consumer->getAccessToken(
                $_GET,
                unserialize($requestsession->requestToken)
            );
            $accesssession->accessToken = serialize($token);
            // Now that we have an Access Token, we can discard the Request Token
            unset($requestsession->requestToken);
            // $this->_redirect();
            $this->_forward('index', 'index', 'default');
        } else {
            // Mistaken request? Some malfeasant trying something?
            throw new Exception('Invalid callback request. Oops. Sorry.');
        }
    }
    
    public function callbackrejectedAction()
    {
        // rejected
    }
}
```

Normally you can get the http client by `$token->getHttpClient($this->config)`
rather than creating `Zend_Http_Client` as I did. But due to some issues 
the request was getting `Service Temporarily Unavailable` as response.

The `Service Temporarily Unavailable` can also be due to permission issues. 
You should also check whether you have given the right permissions for 
roles and resources.

In most case, we would have defined a named route, so you could use the 
url helpers to generate the route. I hope this helps you to move with REST 
and Magento

Resources
---------

[Magento REST API](http://www.magentocommerce.com/api/rest/introduction.html)

[zend oauth introduction](http://framework.zend.com/manual/1.12/en/zend.oauth.introduction.html)

Thanks
------

I would like to thank [PHP Cloud](http://phpcloud.com) for providing the 
free service to deploy the magento shop and test it. Installing and deploying app was super 
simple. So if you have not tried it is time for it.
