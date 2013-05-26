---
layout: post
title: Add WYSIWYG ckeditor to Zend_Textarea element of Zend_Form
categories: [php, zendframework, Zend_Form, Zend_Textarea]
published: true
date: 2009-09-17 10:01
---

Adding a WYSIWYG editor to Zend_Textarea element of zend framework . I don't
know whether this is the right way to this . Anyway I would love to share the
piece of code to you . I am using the ckeditor the opensource WYSIWYG editor
which was previously called fckeditor. Ilove the new look of it than the tiny
mce . So switched to it ![](http://www.harikt.com/sites/all/modules/fckeditor/
fckeditor/editor/images/smiley/msn/regular_smile.gif) .

Extract the files of ckeditor and upload to public folder . I am keeping this
in the /js/ckeditor .

Add the below piece of code to the layout . As we dont need to load the js of
the ckeditor every time we can add a flag.

    
    
    <?php 
     if ( $this->ckeditor ) { 
      echo $this->headScript()->appendFile( $this->baseUrl().'/js/ckeditor/ckeditor.js');
     }
    ?>
    

Now you need a helper . Keep the below code in
/application/views/helpers/SetupEditor.php .

    
    
    <?php
    class Zend_View_Helper_SetupEditor {
    
     function setupEditor( $textareaId ) {
     return "<script type=\"text/javascript\">
     CKEDITOR.replace( '". $textareaId ."' );
      </script>";
     }
    }
    ?>
    

I have used a baseUrl helper also . So if you are new I am keeping it for
those .

    
    
    <?php
    class Zend_View_Helper_BaseUrl {
     function baseUrl() {
     $fc = Zend_Controller_Front::getInstance();
     return $fc->getBaseUrl();
     }
    }
    ?>
    

Now you can include the small piece of code in the view script where you are
printing the form . For this eg: I am using the
application/views/scripts/index/edit.phtml

    
    
    <?php
     $this->ckeditor = 'ckeditor'; //To tell the layout ckeditor must be loaded . 
    ?>
    <h2>Edit Post</h2>
    <div><?php echo $this->postForm; ?></div>
    <!-- Description is the id of the textarea -->
    <?php echo $this->setupEditor( 'Description' ); ?>
    

You must know the name of the id of the textarea to pass to the setupEditor .
I have used the name Description when creating the textarea element . You must
have atleast tried the Zend framework quickstart to understand how it works .
I hope I have not missed any .


