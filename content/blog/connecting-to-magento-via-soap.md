+++
title = "connecting to magento via soap"
date = "2013-07-12"
slug = "2013/07/12/connecting-to-magento-via-soap"
Categories = []
+++

In my earlier post I have shown how you can connect to Magento 
with REST api. In this post let us connect via SOAP.

The below class acts like a proxy to call the magento soap api.

```php
<?php
/**
 * 
 * @author Hari K T
 * 
 */
class My_Soap_Magento
{
    /**
     * 
     * Host name to connect
     * 
     * @var string
     * 
     */
    protected $hostname;

    /**
     * 
     * User name
     * 
     * @var string
     * 
     */
    protected $username;
    
    /**
     * 
     * API Key
     * 
     * @var string
     * 
     */
    protected $apikey;
    
    /**
     * 
     * Zend_Soap_Client
     * 
     * @var Zend_Soap_Client
     * 
     */
    protected $client;
    
    
    protected $session;
    
    /**
     * 
     * Constructor
     * 
     * @param string $hostname The host name
     * 
     * @param string $username The user name of the host
     * 
     * @param string $apikey The apikey of the host
     * 
     */
    public function __construct($hostname, $username, $apikey)
    {        
        $this->hostname = $hostname;
        $this->username = $username;
        $this->apikey   = $apikey;        
    }
    
    /**
     * 
     * Magic method, the methods are named on the basis of Magento SOAP api
     * You don't need to pass the session as the first argument, for convience.
     * 
     * @link http://www.magentocommerce.com/api/soap/introduction.html
     * 
     * @param string $function
     * 
     * @param mixed $args
     * 
     * @return string | null
     * 
     */
    public function __call($function, $args)
    {
        $session = $this->getSession();
        $params = array_merge(array($this->getSession()), $args);
        $result = call_user_func_array(array($this->getClient(), $function), $params);
        if ($result) {
            // I need to get as json
            return Zend_Json_Encoder::encode($result);
        }
        return null;
    }        
    
    /**
     * 
     * Get the session from logging in to the Magento server
     * 
     * @return string
     * 
     */
    public function getSession()
    {
        if (! $this->session) {
            try {
                $this->session = $this->getClient()->login($this->username, $this->apikey);
            } catch (Exception $e) {
                
            }
        }
        return $this->session; 
    }
    
    /**
     * 
     * If we already have a session, we can set the session so it don't 
     * need to login again and get the session. This helps to reduce the 
     * call for login . 
     * 
     * @see getSession()
     * 
     * @param string $session
     * 
     * @return IM_Soap_Magento
     * 
     */
    public function setSession($session)
    {
        $this->session = $session;
        return $this;
    }
    
    /**
     * 
     * Get the Zend_Soap_Client object
     * 
     * @return Zend_Soap_Client
     * 
     */
    public function getClient()
    {
        if (! $this->client) {
            $endpoint  = trim($this->hostname, '/') . '/api/v2_soap/?wsdl';
            $this->client = new Zend_Soap_Client(            
                $endpoint
            );
        }     
        return $this->client;   
    }
}
```

In order to connect you want to create an object of the above 
class `My_Soap_Magento`. You need to get the username and api key
from the magento host.

```php
<?php
$object = new My_Soap_Magento(
    'the-magento-host',
    'username',
    'apikey'
);
```

Now you are done! You can connect to the soap api version 2 of 
Magento server.

Sample how to get the product information, category tree, 
category information, products list etc are shown below.

See we are not passing the session parameter.

```php
<?php
echo "Product Info";
$result = $proxy->catalogProductInfo(16);
echo $result;

echo "Category Tree";
$result = $proxy->catalogCategoryTree();
echo $result;

echo "Category Info";
$result = $proxy->catalogCategoryInfo(10);
echo $result;

echo 'Products List';
$result = $proxy->catalogProductList();
echo $result;
```
