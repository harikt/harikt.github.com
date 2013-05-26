---
layout: post
title:  Complete working example for pagination using Zend_Paginator
categories: [php, zendframework]
published: true
date: 2009-09-15 13:03
---

When I was trying to use pagination I didnot find a complete example . From
different blogs and mannuals Ifinally figured it . So I thought of posting it
for myself and for others trying to learn it .

You need to grab the result and pass to Zend_Paginator .
    
    
    /*
    * Get the page number , default 1
    */
    $page = $this->_getParam('page',1);
    /*
    * Object of Zend_Paginator
    */
    $paginator = Zend_Paginator::factory($result);
    /*
    * Set the number of counts in a page
    */
    $paginator->setItemCountPerPage(2);
    /*
    * Set the current page number
    */
    $paginator->setCurrentPageNumber($page);
    /*
    * Assign to view
    */
    $this->view->paginator = $paginator;
    

I hope you have this code in the indexAction . If its in indexAction add the
below code in the index.phtml view script , else according to the view of your
Action .

    
    
    <h1>Example</h1>
    <?php if (count($this->paginator)): ?>
    <ul>
    <?php 
    /*
    * Iterate through the paginator to show the results
    */
    foreach ($this->paginator as $item): ?>
    <li><?php echo $item['FirstName'] ." ".$item['LastName']; ?></li>
    <?php endforeach; ?>
    </ul>
    <?php endif; ?>
    <?php 
    /*
    * Print the pagination of type , drop down or search type or of your choice. 
    */
    echo $this->paginationControl($this->paginator,
     'Sliding',
     '/partials/my_pagination_control.phtml'); ?>
    

This code is from the zend mannuals , but it didnot tell where to keep this .
You need to keep this in the views folder . I am keeping it in
application/views/scripts/partials/my_pagination_control.phtml . I have added
the 3 types of pagination in this . You can remove or comment it and look how
each type of pagination looks . The drop down is uncommented for now .

    
    
    <?php
    /*
    * Search pagination
    */ 
    ?>
    <?php /*if ($this->pageCount): ?>
    <div class="paginationControl">
    <!-- Previous page link -->
    <?php if (isset($this->previous)): ?>
    <a href="<?php echo $this->url(array('page' => $this->previous)); ?>"> << Previous</a> | 
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
    <?php endif; */?>
    <?php 
    /*
    * Item pagination example
    * 
    */
    ?>
    <!--
    See http://developer.yahoo.com/ypatterns/pattern.php?pattern=itempagination
    -->
    <?php /*if ($this->pageCount): ?>
    <div class="paginationControl">
    <?php echo $this->firstItemNumber; ?> - <?php echo $this->lastItemNumber; ?>
    of <?php echo $this->totalItemCount; ?>
    <!-- First page link -->
    <?php if (isset($this->previous)): ?>
     <a href="<?php echo $this->url(array('page' => $this->first)); ?>">First </a> |
    <?php else: ?>
     <span class="disabled">First</span> |
    <?php endif; ?>
    <!-- Previous page link -->
    <?php if (isset($this->previous)): ?>
     <a href="<?php echo $this->url(array('page' => $this->previous)); ?>"> &lt; Previous </a> |
    <?php else: ?>
     <span class="disabled">&lt; Previous</span> |
    <?php endif; ?>
    <!-- Next page link -->
    <?php if (isset($this->next)): ?>
     <a href="<?php echo $this->url(array('page' => $this->next)); ?>"> Next &gt; </a> |
    <?php else: ?>
     <span class="disabled">Next &gt;</span> |
    <?php endif; ?>
    <!-- Last page link -->
    <?php if (isset($this->next)): ?>
     <a href="<?php echo $this->url(array('page' => $this->last)); ?>"> Last </a>
    <?php else: ?>
     <span class="disabled">Last</span>
    <?php endif; ?>
    </div>
    <?php endif; */?>
    <?php
    /*
    * Drop down paginaton example
    */
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
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/prototype/1.6.0.2/prototype.js"></script>
    <script type="text/javascript">
    $('paginationControl').observe('change', function() {
     window.location = this.options[this.selectedIndex].value;
    })
    </script>

Hope it works for you . Thanks


