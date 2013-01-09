---
layout: post
title: "The moving from Drupal7 to octopress"
date: 2012-12-17 23:23
comments: true
categories: [drupal7, octopress]
---
Recently I ported the blog from [Drupal7](http://drupal.org) to [octopress](http://octopress.org/) for certain reasons. The php script that helped me to do the porting from drupal to octopress is given below. This is a port of the ruby script with some additional fixes on the SQL. This needs [pandoc](http://johnmacfarlane.net/pandoc/) to be installed to convert from Html to Markdown. There is also slight isssue with the syntaxhighlighter, which you may want to manually fix.

``` php drupal7 to octopress
<?php
function drupalProcess($dbname, $username, $password, $host = 'localhost') {
    $dsn = "mysql:host=$host;dbname=" . $dbname;
    $pdo = new Pdo($dsn, $username, $password, $options = array(
          PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
      )
    );
    $sql = "SELECT n.nid, 
            n.title, 
            n.created, 
            n.changed, 
            b.body_value AS 'body', 
            b.body_summary, 
            b.body_format, 
            n.status, 
            l.alias AS 'slug', 
            GROUP_CONCAT( d.name SEPARATOR ', ' ) AS 'tags' 
        FROM node AS n 
        JOIN field_data_body b ON b.entity_id = n.nid 
        JOIN taxonomy_index t ON t.nid = n.nid 
        JOIN taxonomy_term_data d ON t.tid = d.tid 
        LEFT JOIN url_alias AS l ON l.source = CONCAT( 'node/', n.nid ) 
        WHERE n.type = 'blog' AND b.revision_id = n.vid 
        GROUP BY n.nid";
    $sth = $pdo->prepare($sql);
    $sth->execute();
    $rows = $sth->fetchAll();
    $bool = array(0 => 'false', 1 => 'true');
    foreach ($rows as $row) {
        $fp = fopen('htmlcontents.html', 'w');
        fwrite($fp, $row['body']);
        fclose($fp);
        $datetime = new DateTime();
        $datetime->setTimestamp($row['created']);
        $date = $datetime->format('Y-m-d');
        $contents = '---' . "\n";
        $contents .= 'layout: post' . "\n";
        $contents .= 'title: ' . $row['title'] . "\n";
        $contents .= 'categories: [' . $row['tags'] . ']' . "\n";
        $contents .= 'published: ' . $bool[$row['status']] . "\n";
        $contents .= 'date: ' . $datetime->format('Y-m-d H:i') . "\n";
        $contents .= '---' . "\n";
        if (!empty($row['slug'])) {
            $list = explode('/', $row['slug']);
            if (count($list) > 1) {
                $row['slug'] = end($list);
            }
        } else {
            $row['slug'] = 'node-' . $row['nid'];
        }

        $pandoc = '';
        exec('pandoc -t markdown -f html htmlcontents.html', &$pandoc);
        $contents .= implode(' ', $pandoc);
        $url = 'source/posts/' . $date . '-' . $row['slug'] . '.markdown';
        
        $contents .= "\n";
        if ( !file_exists($url)) {
            $fp = fopen($url, "w");
            fwrite($fp, $contents);
            fclose($fp);
        } else {
            echo "File exists issue : " . $row['slug'] . "\n";
        }
    }
}
//optional hostname
drupalProcess('dbname', 'username', 'password');
```

Happy porting!
