---
layout: post
title: Zend framework tutorial, build your Blog
tags: [php, zend, zendframework, tutorial, blog]
published: true
date: 2009-09-11 22:39
---

I have been trying to work with zendframework 1.8 and now with 1.9 . I have
created a simple blog application using zend framework ( You may call it as a
zend framework tutorial ![](http://www.harikt.com/sites/all/libraries/fckedito
r/editor/images/smiley/msn/regular_smile.gif) . Changing name from "A simple
Blog tutorial using Zend framework 1.9" to Zendframework tutorial : Developing
a blog for some search engine optimization technique ) . When I say a blog
application with zend framework , never expect it , something like wordpress .
Its a simple application which can add posts , add comments , can fetch albums
from Picasa now , which I developed to learn Zend framework .

As I am new to zendframework and MVC , I know there is errors and some are for
my convienience I have placed as it is I am new to unit testing , so have not
written any code for test data too . sorry . I know the drawbacks of this
application and the database itself is not proper . But I am publishing it if
this helps some one to understand Zend_ACL , Zend_Auth , Zend_Form etc. I have
added a gallery to get the albums , photos from picasa using the Zend_Gdata
API . Thinking to implement to add photos through admin side . Need to
implement the feature in admin . Will do it if I get some time ![](http://www.
harikt.com/sites/all/modules/fckeditor/fckeditor/editor/images/smiley/msn/regu
lar_smile.gif)

I have looked various blogs and some are upto date applications and some are
not . I am using the Zend Toolkit as I love to work in command line rather
than GUI . I have added the link to download the complete zend framework 1.9
blog application example . Feel free to grab the complete working example code
of the zend framework 1.9 from github to which a link is given to the last of
the document .

Development Environment :

1 ) LAMP or WAMP or MAMP

2 ) Zendframework 1.9 configured .

3 ) I am using eclipse , netbeans and zend studio i5 . If you are using zend
studio i5 , there is no need to look the command line, many are already in it
.

I hope you have configured the first two . Now lets move to command line to
create project , controllers and actions . The dollar ( $ ) symbol represents
the command prompt .

    
    
    $ zf create project blog

This will create the zend framework directory structure > 1.8 . Change the
directory . ie cd <projectname>

```php
hari@hari-laptop:/var/www/blog$ zf show profile
ProjectDirectory
    ProjectProfileFile
    ApplicationDirectory
        ConfigsDirectory
            ApplicationConfigFile
        ControllersDirectory
            ControllerFile
                ActionMethod
            ControllerFile
        ModelsDirectory
        ViewsDirectory
            ViewScriptsDirectory
                ViewControllerScriptsDirectory
                    ViewScriptFile
                ViewControllerScriptsDirectory
                    ViewScriptFile
            ViewHelpersDirectory
        BootstrapFile
    LibraryDirectory
    PublicDirectory
        PublicIndexFile
        HtaccessFile
    TestsDirectory
        TestPHPUnitConfigFile
        TestApplicationDirectory
            TestApplicationBootstrapFile
        TestLibraryDirectory
            TestLibraryBootstrapFile

```

This is how the directory structure will appear .

    
    
     zf create controller posts

    Creating a controller at
    //var/www/blog/application/controllers/PostsController.php

    Creating an index action method in controller posts

    Creating a view script for the index action method at
    //var/www/blog/application/views/scripts/posts/index.phtml

    Creating a controller test file at
    //var/www/blog/tests/application/controllers/PostsControllerTest.php

    Updating project profile '//var/www/blog/.zfproject.xml'

    
    
     zf create action view posts

    Creating an action named view inside controller at
    //var/www/blog/application/controllers/PostsController.php

    Updating project profile '//var/www/blog/.zfproject.xml'

    Creating a view script for the view action method at
    //var/www/blog/application/views/scripts/posts/view.phtml

    Updating project profile '//var/www/blog/.zfproject.xml'

    
    
    zf create action edit posts

    Creating an action named edit inside controller at
    //var/www/blog/application/controllers/PostsController.php

    Updating project profile '//var/www/blog/.zfproject.xml'

    Creating a view script for the edit action method at
    //var/www/blog/application/views/scripts/posts/edit.phtml

    Updating project profile '//var/www/blog/.zfproject.xml'

    
    
    zf create action add posts

    Creating an action named add inside controller at
    //var/www/blog/application/controllers/PostsController.php

    Updating project profile '//var/www/blog/.zfproject.xml'

    Creating a view script for the add action method at
    //var/www/blog/application/views/scripts/posts/add.phtml

    Updating project profile '//var/www/blog/.zfproject.xml'

    
    
    zf create action login index

    Creating an action named login inside controller at
    //var/www/blog/application/controllers/IndexController.php

    Updating project profile '//var/www/blog/.zfproject.xml'

    Creating a view script for the login action method at
    //var/www/blog/application/views/scripts/index/login.phtml

    Updating project profile '//var/www/blog/.zfproject.xml'

    
    
    zf create action logout index

    Creating an action named logout inside controller at
    //var/www/blog/application/controllers/IndexController.php

    Updating project profile '//var/www/blog/.zfproject.xml'

    Creating a view script for the logout action method at
    //var/www/blog/application/views/scripts/index/logout.phtml

    Updating project profile '//var/www/blog/.zfproject.xml'

    Create a database and add the tables users , comments and posts .

        
    
    CREATE TABLE IF NOT EXISTS `comments` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `Post_id` int(11) NOT NULL,
      `Description` varchar(300) NOT NULL,
      `Name` varchar(200) NOT NULL,
      `Email` varchar(250) NOT NULL,
      `Webpage` varchar(200) NOT NULL,
      `Postedon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
    
    
    CREATE TABLE IF NOT EXISTS `posts` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `Title` varchar(250) NOT NULL,
      `Description` text NOT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
    
    
    CREATE TABLE IF NOT EXISTS `users` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `Username` varchar(200) NOT NULL,
      `Password` varchar(250) NOT NULL,
      `Role` varchar(10) NOT NULL,
      `Name` varchar(200) NOT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
    

Add the code to Bootstrap.php so the other classes can be autoloaded . Same
like __autoload() .

    
    
    protected function _initAutoload()
    {
        $moduleLoader = new Zend_Application_Module_Autoloader(array(
            'namespace' => '',
            'basePath' => APPLICATION_PATH));
        return $moduleLoader;
    }
    


Add the layout and db connection details in
application/configs/application.ini . The complete code is kept below

    
    
    [production]
    phpSettings.display_startup_errors = 0
    phpSettings.display_errors = 0
    includePaths.library = APPLICATION_PATH "/../library"
    bootstrap.path = APPLICATION_PATH "/Bootstrap.php"
    bootstrap.class = "Bootstrap"
    resources.frontController.controllerDirectory = APPLICATION_PATH "/controllers"
    resources.layout.layoutPath = APPLICATION_PATH "/layouts/scripts"
    resources.view[] = 
    resources.db.adapter = PDO_MYSQL
    resources.db.params.host = localhost
    resources.db.params.username = root
    resources.db.params.password = 
    resources.db.params.dbname = hari_zendblog
    [staging : production]
    [testing : production]
    phpSettings.display_startup_errors = 1
    phpSettings.display_errors = 1
    [development : production]
    phpSettings.display_startup_errors = 1
    phpSettings.display_errors = 1
    

Add application/layouts/scripts/layout.phtml file with the code below

    
    
    <?php 
    echo $this->doctype() ?>
    <html xmlns="http://www.w3.org/1999/xhtml"> 
    <head>  
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
      <title>Bloggers turns to developers</title>
      <?php echo $this->headLink()->appendStylesheet('/quickstart/public/css/global.css') ?>
      <?php echo $this->headLink()->prependStylesheet($this->baseUrl().'/css/main.css'); ?>
    </head> 
    <body>
    <div id="header" style="background-color: #EEEEEE; height: 30px;">
        <div id="header-logo" style="float: left">
            <b><a href="<?php echo $this->baseurl(); ?>">ZF Quickstart Application</a></b>&nbsp; &nbsp; 
            <a href="<?php 
            if( Zend_Auth::getInstance()->hasIdentity() ) { 
                $str = "/index/logout";
                $log = "Logout";  
               } else { 
                   $str = "/index/login";
                   $log = "Login";  
               } 
               echo $this->baseurl().$str; ?>"><?php echo $log; ?></a>
        </div>
    </div>
    <div><?php echo $this->layout()->content ?></div>
    </body>
    </html>
     

You can insert sample datas through the phpmyadmin or what ever way you like .
So we can show some posts in the front . Add the below code to indexActon of
IndexController .
    
    
    public function indexAction()
    {
        // action body
        $posts = new Model_DbTable_Posts();
        $result = $posts->getPosts();
        /* The below line is for pagination */
        $page = $this->_getParam('page',1);
        $paginator = Zend_Paginator::factory($result);
        $paginator->setItemCountPerPage(2);
        /**
         * Number of items in a page . I have kept 2 so you can easily 
         * see the pagination when there is 3 items inserted to posts table . 
         */
        $paginator->setCurrentPageNumber($page);
        $this->view->paginator = $paginator;
    }

The complete code of IndexController.php is given below .

    
    <?php
    class IndexController extends Zend_Controller_Action
    {
        public function init()
        {
            /* Initialize action controller here */
        }

        public function indexAction()
        {
            // action body
            $posts = new Model_DbTable_Posts();
            $result = $posts->getPosts();
            $page = $this->_getParam('page',1);
            $paginator = Zend_Paginator::factory($result);
            $paginator->setItemCountPerPage(2);
            $paginator->setCurrentPageNumber($page);
            $this->view->paginator = $paginator;
        }
        
        public function loginAction()
        {        
            $loginForm = new Form_Login();
            $redirect = $this->getRequest()->getParam('redirect', 'index/index');
            $loginForm->setAttrib('redirect', $redirect );
            $auth = Zend_Auth::getInstance();
            if(Zend_Auth::getInstance()->hasIdentity()) {
                $this->_redirect('/index/hello');
            } else if ($this->getRequest()->isPost()) {
                if ( $loginForm->isValid($this->getRequest()->getPost()) ) {
                    $username = $this->getRequest()->getPost('username');
                    $pwd = $this->getRequest()->getPost('pass');
                    $authAdapter = new Model_AuthAdapter($username, $pwd);
                    $result = $auth->authenticate($authAdapter);
                    if(!$result->isValid()) {
                        switch ($result->getCode()) {
                           case Zend_Auth_Result::FAILURE_CREDENTIAL_INVALID:
                                $this->view->errors = 'user credentials not found';
                        }
                    } else {
                        //Successfully logged in
                        $this->_redirect( $redirect );
                    }
                }
            }
            $this->view->loginForm = $loginForm;
    //        $this->_redirect($redirectUrl);
        }
        
        public function logoutAction()
        {
            $auth = Zend_Auth::getInstance();
            $auth->clearIdentity();
            $this->_redirect('/');
        }
    }
    

<strike>Forgot to add the post controller </strike>. Added after seeing the
comment . Thanks for notifying me .

    
    
    <?php
    
    class PostsController extends Zend_Controller_Action
    {
    
    	public function init()
    	{
    		/* Initialize action controller here */
    	}
    
    	public function indexAction()
    	{
    		// action body
    	}
    
    	public function viewAction()
    	{
    		// action body
    		$postid = (int)$this->_getParam('id');
    		if( empty($postid) ) {
    		}
    		$post = new Model_DbTable_Posts();
    		$result = $post->getPost($postid);
    		$this->view->post = $result;
    		$commentsObj = new Model_DbTable_Comments();
    		$request = $this->getRequest();
    		$commentsForm = new Form_Comments();
    		/*
    		 * Check the comment form has been posted
    		 */
    		if ($this->getRequest()->isPost()) {
    			if ($commentsForm->isValid($request->getPost())) {
    				$model = new Model_DbTable_Comments();
    				$model->saveComment($commentsForm->getValues());
    				$commentsForm->reset();
    			}
    		}
    		$data = array( 'id'=> $postid );
    		$commentsForm->populate( $data );
    		$this->view->commentsForm = $commentsForm;
    		$comments = $commentsObj->getComments($postid);
    		$this->view->comments = $comments;
    		$this->view->edit = '/posts/edit/id/'.$postid;
    	}
    
    	public function commentsAction()
    	{
    		// action body
    	}
    
    	public function addAction()
    	{
    		// action body
    		if(!Zend_Auth::getInstance()->hasIdentity()) {
    			$this->_redirect('index/index');
    		}
                    $acl = new Model_Acl();
    		$identity = Zend_Auth::getInstance()->getIdentity();
            if( $acl->isAllowed( $identity['Role'] ,'posts','add') ) {
                $request = $this->getRequest();
                $postForm = new Form_Post();
                if ($this->getRequest()->isPost()) {
                        if ($postForm->isValid($request->getPost())) {
                                $model = new Model_DbTable_Posts();
                                $model->savePost($postForm->getValues());
                                $this->_redirect('index/index');
                        }
                }
                $this->view->postForm = $postForm;
            }
    	}
    
    	public function editAction()
    	{
    		// action body
    		$request = $this->getRequest();
    		$postid = (int)$request->getParam('id');
    		if(!Zend_Auth::getInstance()->hasIdentity()) {
    			$this->_redirect('posts/view/id/'.$postid);
    		}
    		$identity = Zend_Auth::getInstance()->getIdentity();
    		
    		$acl = new Model_Acl();
    		if( $acl->isAllowed( $identity['Role'] ,'posts','edit') ) {
    			$postForm = new Form_Post();
    			$postModel = new Model_DbTable_Posts();
    			if ($this->getRequest()->isPost()) {
    				if ($postForm->isValid($request->getPost())) {
    					$postModel->updatePost($postForm->getValues());
    					$this->_redirect('posts/view/id/'.$postid);
    				}
    			} else {
    				$result = $postModel->getPost($postid);
    				$postForm->populate( $result );
    			}
    			$this->view->postForm = $postForm;
    		} else {
    			var_dump( $identity['Role'] );
    			//$this->_redirect('posts/view/id/'.$postid);
    		}
    	}
    
    }
    

Now you need to create a connection to posts table so that we can do insertion
, edit etc . Keep the file in application/Models/DbTable/Posts.php

    
    
    <?php
    class Model_DbTable_Posts extends Zend_Db_Table_Abstract
    {
        protected $_name = 'posts';
        public function getPosts()
        {
            $orderby = array('id DESC');
            $result = $this->fetchAll('1', $orderby );
            return $result->toArray();
        }
        public function getPost( $id )
        {
            $id = (int)$id;
            $row = $this->fetchRow('id = ' . $id);
            if (!$row) {
                throw new Exception("Count not find row $id");
            }
            return $row->toArray();
        }
        /*
         * Add new posts
         */
        public function savePost( $post )
        {
            $data = array( 'Title'=> $post['Title'],
                    'Description'=> $post['Description']);
            $this->insert($data);
        }
        /*
         * Update old posts
         */
        public function updatePost( $post )
        {
            $data = array(
                    'id'=> $post['id'],
                    'Title'=> $post['Title'],
                    'Description'=> $post['Description']);
            $where = 'id = '.$post['id'];
            $this->update($data , $where );
        }
    }



Create application/Models/DbTable/Users.php

    
    
    <?php
    class Model_DbTable_Users extends Zend_Db_Table_Abstract
    {
        protected $_name = 'users';
        public function findCredentials($username, $pwd)
        {
            $select = $this->select()->where('username = ?', $username)
                ->where('password = ?', $this->hashPassword($pwd));
            $row = $this->fetchRow($select);
            if($row) {
                return $row;
            }
            return false;
        }

        protected function hashPassword($pwd)
        {
            return md5($pwd);
        }
    }

Create application/Models/DbTable/Comments.php

    
    
    <?php
    class Model_DbTable_Comments extends Zend_Db_Table_Abstract
    {
        protected $_name = 'comments';
        public function getComments( $postid ) 
        {
            $result = $this->fetchAll( "post_id = '$postid'"  );
            return $result->toArray();
        }
        public function saveComment( $commentForm )
        {
            $data = array('post_id' => $commentForm['id'] ,
                    'Description' => $commentForm['comment'],
                    'Name' => $commentForm['name'],
                    'Email' => $commentForm['email'],
                    'Webpage' => $commentForm['webpage'] );
            $this->insert($data);
        }
    }

Now lets create a login form in /application/forms/Login.php directory .

    
    
    <?php
    class Form_Login extends Zend_Form
    {
        public function __construct()
        {
            parent::__construct($options);
            $this->setName('UserLogin');
            $username = new Zend_Form_Element_Text('username');
            $username->setLabel('User Name')
                    ->setRequired(true)
                    ->addFilter('StripTags')
                    ->addFilter('StringTrim')
                    ->addValidator('NotEmpty');
            $pass = new Zend_Form_Element_Password('pass');
            $pass->setLabel('Password')
                    ->setRequired(true)
                    ->addFilter('StripTags')
                    ->addFilter('StringTrim')
                    ->addValidator('NotEmpty');
            $submit = new Zend_Form_Element_Submit('submit');
            $redirect = new Zend_Form_Element_Hidden('redirect');
            $submit->setAttrib('id', 'submitbutton');
            $this->addElements( array ( $username, $pass, $submit));
        }
    }

Create a form for posting and commenting

application/forms/posts.php

    
    
    <?php
    class Form_Post extends Zend_Form
    {
        public function __construct()
        {
            parent::__construct($options);
            $this->setName('Posts');
            $id = new Zend_Form_Element_Hidden('id');
            $title = new Zend_Form_Element_Text('Title');
            $title->setLabel('Title')
                    ->setRequired(true)
                    ->addFilter('StripTags')
                    ->addFilter('StringTrim')
                    ->addValidator('NotEmpty');
            $description = new Zend_Form_Element_Textarea('Description');
            $description->setLabel('Description')
                    ->setRequired(true)
                    ->setAttrib('rows',20)
                    ->setAttrib('cols',50)
                    ->addFilter('StripTags')
                    ->addFilter('StringTrim')
                    ->addValidator('NotEmpty');
            $submit = new Zend_Form_Element_Submit('submit');
            $submit->setAttrib('id', 'submitbutton');
            $this->addElements( array( $id, $title, $description, $submit ));
        }
    }

Create a comments form application/forms/Comments.php for adding comments

    
    
    <?php
    class Form_Comments extends Zend_Form
    {
        public function __construct()
        {
            $acl = new Model_Acl();
            $identity = Zend_Auth::getInstance()->getIdentity();
            /*
            * Check whether they have permission to add comments
            */
            if( Zend_Auth::getInstance()->hasIdentity()
            && $acl->isAllowed( $identity['role'] ,'comments','add') ) {
                parent::__construct($options);
                $this->setName('Comments');
                $id = new Zend_Form_Element_Hidden('id');
                $name = new Zend_Form_Element_Text('name');
                $name->setLabel('Your Name')
                    ->setRequired(true)
                    ->addFilter('StripTags')
                    ->addFilter('StringTrim')
                    ->addValidator('NotEmpty');
                $email = new Zend_Form_Element_Text('email');
                $email->setLabel('Email')
                    ->setRequired(true)
                    ->addFilter('StripTags')
                    ->addFilter('StringTrim')
                    ->addValidator('NotEmpty');
                $webpage = new Zend_Form_Element_Text('webpage');
                $webpage->setLabel('Webpage')
                    ->setRequired(true)
                    ->addFilter('StripTags')
                    ->addFilter('StringTrim')
                    ->addValidator('NotEmpty');
                $comment = new Zend_Form_Element_Textarea('comment');
                $comment->setLabel('Comments')
                    ->setRequired(true)
                    ->setAttrib('rows',7)
                    ->setAttrib('cols',30)
                    ->addFilter('StripTags')
                    ->addFilter('StringTrim')
                    ->addValidator('NotEmpty');
                $submit = new Zend_Form_Element_Submit('submit');
                $submit->setAttrib('id', 'submitbutton');
                $this->addElements( array ($id, $name, $email, $webpage, $comment, $submit));
            }
        }
    }

Create application/Models/Acl.php

    
    
    <?php
    class Model_Acl extends Zend_Acl 
    {
        public function __construct() 
        {
            /*
             *  Add a new role called "guest"
             *  Guest can view contents of the site 
             */
            $this->addRole(new Zend_Acl_Role('guest'));
            /* 
             * Add a role called user, which inherits from guest
             * Users can post comments in site
             */
            $this->addRole(new Zend_Acl_Role('user'), 'guest');
            /* 
             * Add a role called blogger, which inherits from user
             * Bloggers can post contents
             */
            $this->addRole(new Zend_Acl_Role('blogger'), 'user');
            /*
             * Add a role for admin which inherits blogger
             * With every privilages
             */
            $this->addRole(new Zend_Acl_Role('admin'), 'blogger');
            //Add a resource called posts
            $this->add(new Zend_Acl_Resource('posts'));
            //Add a resource called edit, which inherits posts
            //$this->add(new Zend_Acl_Resource('edit'), 'posts');
            //Add a resource called edit
            //$this->add(new Zend_Acl_Resource('add'), 'posts');
            //Finally, we want to allow guests to view pages
            $this->allow('guest', 'posts', 'view');
            // Bloggers can add, edit posts
            $this->allow('blogger', 'posts', 'edit');
            $this->allow('blogger', 'posts', 'add');
        }
    }

Create application/Models/AuthAdapter.php

    
    
    <?php
    class Model_AuthAdapter implements Zend_Auth_Adapter_Interface
    {
        protected $username;
        protected $password;
        protected $user;
        public function __construct($username, $password) {
            $this->username = $username;
            $this->password = $password;
            $this->user = new Model_DbTable_Users();
        }
        public function authenticate()
        {
            $match = $this->user->findCredentials($this->username, $this->password);
            //var_dump($match);
            if(!$match) {
                $result = new Zend_Auth_Result(Zend_Auth_Result::FAILURE_CREDENTIAL_INVALID, null);
            } else {
                $user = current($match);
                $result = new Zend_Auth_Result(Zend_Auth_Result::SUCCESS, $user);
            }
            return $result;
        }
    }

Create application/views/helpers/BaseUrl.php

    
    
    <?php
    class Zend_View_Helper_BaseUrl {
        function baseUrl() {
            $fc = Zend_Controller_Front::getInstance();
            return $fc->getBaseUrl();
        }
    }
    ?>

Create application/views/helpers/LinkTo.php

    
    
    <?php
    class Zend_View_Helper_LinkTo
    {
        protected static $baseUrl = null;
        public function linkTo($path)
        {
            if (self::$baseUrl === null) {
                $request = Zend_Controller_Front::getInstance()->getRequest();
                $root = '/' . trim($request->getBaseUrl(), '/');
                if ($root == '/') {
                    $root = '';
                }
                self::$baseUrl = $root . '/';
            }
            return self::$baseUrl . ltrim($path, '/');
        }
    }



Create application/views/helpers/LoggedInUser.php

    
    
    <?php
    class Zend_View_Helper_LoggedInUser
    {
        protected $_view;
        function setView($view)
        {
        $this->_view = $view;
        }
        function loggedInUser()
        {
            $auth = Zend_Auth::getInstance();
            if($auth->hasIdentity())
            {
                $logoutUrl = $this->_view->linkTo('auth/logout');
                $user = $auth->getIdentity();
                $username = $this->_view->escape(ucfirst($user->username));
                $string = 'Logged in as ' . $username . ' | <a href="' .
                $logoutUrl . '">Log out</a>';
            } else {
                $loginUrl = $this->_view->linkTo('auth/identify');
                $string = '<a href="'. $loginUrl . '">Log in</a>';
            }
            return $string;
        }
    }
     

Change the contents of application/views/scripts/index/index.phtml with

    
    
    <?php if (count($this->paginator)): ?>
    <?php foreach ($this->paginator as $post ): ?>
    <div class="post">
      <div class="title"><a href="<?php echo $this->baseUrl()."/posts/view/id/".$post['id']; ?>"><?php echo $this->escape($post['Title']); ?></a></div>
      <div class="description"><?php echo nl2br(substr( strip_tags( $post['Description']), 0 , 300)); ?></div>
      <div class="commentscount">Comments( count )</div>
    </div>
    <?php endforeach; ?>
    <?php endif; ?>
    <div class="pagination"><?php echo $this->paginationControl($this->paginator,
                                        'Sliding',
                                        '/partials/my_pagination_control.phtml'); ?></div>
    

Change the contents of application/views/scripts/index/login.phtml with

    
    
    <?php echo $this->errors; ?>
    <?php echo $this->loginForm; ?>

Change the contents of application/views/scripts/index/logout.phtml with

    
    
    <div>Successfully Logged out</div>
    

Create application/views/scripts/partials/my_pagination_control.phtml with (
You can place partials in a different folder too . I forgot to change that )

    
    
    <?php if ($this->pageCount): ?>
    <div class="paginationControl">
    <!-- Previous page link -->
    <?php if (isset($this->previous)): ?>
      <a href="<?php echo $this->url(array('page' => $this->previous)); ?>">
        &lt; Previous
      </a> |
    <?php else: ?>
      <span class="disabled">&lt; Previous</span> |
    <?php endif; ?>
    <!-- Numbered page links -->
    <?php foreach ($this->pagesInRange as $page): ?>
      <?php if ($page != $this->current): ?>
        <a href="<?php echo $this->url(array('page' => $page)); ?>">
            <?php echo $page; ?>
        </a> |
      <?php else: ?>
        <?php echo $page; ?> |
      <?php endif; ?>
    <?php endforeach; ?>
    <!-- Next page link -->
    <?php if (isset($this->next)): ?>
      <a href="<?php echo $this->url(array('page' => $this->next)); ?>">
        Next &gt;
      </a>
    <?php else: ?>
      <span class="disabled">Next &gt;</span>
    <?php endif; ?>
    </div>
    <?php endif; ?>
    <?php
    /*
     * Drop down paginaton example
     */
    /*
    ?>
    <?php if ($this->pageCount): ?>
    <select id="paginationControl" size="1">
    <?php foreach ($this->pagesInRange as $page): ?>
      <?php $selected = ($page == $this->current) ? ' selected="selected"' : ''; ?>
      <option value="<?php
            echo $this->url(array('page' => $page));?>"<?php echo $selected ?>>
        <?php echo $page; ?>
      </option>
    <?php endforeach; ?>
    </select>
    <?php endif; ?>
    <script type="text/javascript"
         src="http://ajax.googleapis.com/ajax/libs/prototype/1.6.0.2/prototype.js">
    </script>
    <script type="text/javascript">
    $('paginationControl').observe('change', function() {
        window.location = this.options[this.selectedIndex].value;
    })
    </script>
    */?>

Change application/views/scripts/posts/add.phtml with

    
    
    <div><?php echo $this->postForm; ?></div>
    

Change application/views/scripts/posts/edit.phtml with

    
    
    <h2>Edit Post</h2>
    <div><?php echo $this->postForm; ?></div>
    

Change application/views/scripts/posts/view.phtml with


    <div class="title"><?php echo $this->post['Title']; ?></div>
    <div class="description"><?php echo $this->post['Description'];  ?></div>
    <?php
        $acl = new Model_Acl(); 
        $identity = Zend_Auth::getInstance()->getIdentity();
        if( Zend_Auth::getInstance()->hasIdentity() && $acl->isAllowed( $identity['role'] ,'posts','edit') ) : ?>
    <div><a href="<?php echo $this->baseurl().$this->edit; ?>">Edit</a></div> 
    <?php endif; ?> 
    <div class="comments">
        <?php if( count($this->comments) ) : ?>
            <?php foreach( $this->comments as $comment ) : ?>
                <div class="postedby"><a href="<?php echo $comment['Webpage']; ?>" ><?php echo $this->escape( $comment['Name'] ); ?></a> on <span><?php echo $this->escape( date( 'd-m-Y', strtotime($comment['Postedon']) ) ); ?></span></div>
                <div class="comment"><?php echo $this->escape( $comment['Description'] ); ?></div>
            <?php endforeach; ?>
        <?php else : ?>
        <div>No comments</div>
        <?php endif; ?>
    </div>
    <div class="newcomments">
    <?php if( Zend_Auth::getInstance()->hasIdentity() ) : 
            echo $this->commentsForm;
        else :
            ?>Login to Post comments<?php 
        endif;
    ?>
    </div>
    

I hope I have not missed any when adding to the blog . If there is any erros
do let me know . You can grab the working copy from git , that will be good if
there is some errors . I have got many helps from more than 50 blogs . I have
made a custom search engine for the zend framework learning too . In the
earlier post I have posted .

Thanks and I hope you will enjoy my small blog, and If there is any confusing
part let me know it. You can post comments rather than directly mailing to me
. You can grab the piece of code from
[http://github.com/harikt/zendblog](http://github.com/harikt/zendblog) and
don't be shy as Jon Lembord of http://zendcasts.com says . . Thanks for the
wonderful facility provided by github and git .

I have also posted a new post for those who are looking for a module and admin
layout. Do check it and get the files from http://www.harikt.com/content/base-
files-start-your-zend-framework-project . This may be useful for you to start
your zend framework project .

