---
layout: post
title: "Experimenting on different framework"
date: 2015-01-13 07:54:53 +0530
comments: true
categories: [framework]
---

Whenever I get some time, I try to learn and experiment on different frameworks. I would like to stay away from pin pointing to the frameworks I have looked, so they don't feel bad.

## Long live components

Components are awesome!. You can plug your favourite components to any system. Thank you composer.
One strong preference choosing a framework was

* It should be built from components

### Advantage

* I could use those components on a different project without spending long time learning a different API.

## Choosing Symfony as a framework

* Symfony framework have been used in production for long, big community, and backed by Sensio Labs.
* Many of the libraries, cms and frameowrks that exists on packagist rely on symfony components.

Look at [phinx](http://phinx.org) a db migration tool, [drupal 8](https://drupal.org) etc. These makes use of components like `symfony/console`, `symfony/http-foundation`, `symfony/router` etc.

Some of the good things I like in symfony console component are its [helpers](http://symfony.com/doc/current/components/console/helpers/index.html).

### Table

```php
use Symfony\Component\Console\Helper\Table;
use Symfony\Component\Console\Output\ConsoleOutput;

$output = new ConsoleOutput();
$table = new Table($output);
$table
    ->setHeaders(array('ISBN', 'Title', 'Author'))
    ->setRows(array(
        array('99921-58-10-7', 'Divine Comedy', 'Dante Alighieri'),
        array('9971-5-0210-0', 'A Tale of Two Cities', 'Charles Dickens'),
        array('960-425-059-0', 'The Lord of the Rings', 'J. R. R. Tolkien'),
        array('80-902734-1-6', 'And Then There Were None', 'Agatha Christie'),
    ))
;
$table->render();
```

## Progress bar

```php
use Symfony\Component\Console\Helper\ProgressBar;
use Symfony\Component\Console\Output\ConsoleOutput;

$output = new ConsoleOutput();

// create a new progress bar (50 units)
$progress = new ProgressBar($output, 50);

// start and displays the progress bar
$progress->start();

$i = 0;
while ($i++ < 50) {
    // ... do some work

    // advance the progress bar 1 unit
    $progress->advance();

    // you can also advance the progress bar by more than 1 unit
    // $progress->advance(3);
}

// ensure that the progress bar is at 100%
$progress->finish();
```

## Question

```php
use Symfony\Component\Console\Helper\QuestionHelper;
use Symfony\Component\Console\Output\ConsoleOutput;
use Symfony\Component\Console\Input\StringInput;
use Symfony\Component\Console\Question\ConfirmationQuestion;
use Symfony\Component\Console\Question\ChoiceQuestion;

$output = new ConsoleOutput();
$helper = new QuestionHelper();
$input = new StringInput('action');
$question = new ConfirmationQuestion('Continue with this action?', false);

if ($helper->ask($input, $output, $question)) {
    $question = new ChoiceQuestion(
        'Please select your favorite color (defaults to red)',
        array('red', 'blue', 'yellow'),
        0
    );
    $question->setErrorMessage('Color %s is invalid.');

    $color = $helper->ask($input, $output, $question);
    $output->writeln('You have just selected: '.$color);
} else {
    $output->writeln('Exiting !');
}
```

## Hidden Passwords

```php
use Symfony\Component\Console\Helper\QuestionHelper;
use Symfony\Component\Console\Output\ConsoleOutput;
use Symfony\Component\Console\Input\StringInput;
use Symfony\Component\Console\Question\Question;

$output = new ConsoleOutput();
$helper = new QuestionHelper();
$input = new StringInput('action');
$question = new Question('What is the database password?');
$question->setHidden(true);
$question->setHiddenFallback(false);

$password = $helper->ask($input, $output, $question);
$output->writeln('Entered password : ' . $password);
```

and more.. I hope you will also add `symfony/console` into your list.

## Http Foundation

The `symfony/http-foundation` is another extensively used component. It is actually [Aura.Web](https://github.com/auraphp/Aura.Web) + [Aura.Session](https://github.com/auraphp/Aura.Session) with more session handlers. Used by `drupal`, `laravel` etc in core. When working on mixed projects like `drupal`, `laravel` etc, it is good to be in your list.

```php
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

$request = Request::createFromGlobals();
$response = new Response(
    'Hello symfony',
    Response::HTTP_OK,
    array('content-type' => 'text/html')
);
$response->send();
```

## Finder

Another wonderful component is the finder.

```php
use Symfony\Component\Finder\Finder;

$finder = new Finder();

$iterator = $finder
  ->files()
  ->depth(0)
  ->in(__DIR__);

foreach ($iterator as $file) {
    print $file->getRealpath()."\n";
}
```

## Filesystem

Filesystem is another nice component which helps you to copy, rename, create directories.

## Complex components

So far, most of the components are easy ones. One of the complex component is the security component. It tries to do authentication and authorization.

As a person who have worked with zend framework, I love how  [authentication](http://framework.zend.com/manual/current/en/modules/zend.authentication.intro.html) and [authorization](http://framework.zend.com/manual/current/en/modules/zend.permissions.acl.intro.html) is done. I do love the latest  [Aura.Auth](https://github.com/auraphp/Aura.Auth) library.

If you are using symfony as a framework, there is a bundle to rescue. Yes, [FOSUserBundle](https://github.com/FriendsOfSymfony/FOSUserBundle). I believe most of them who use symfony will be using it.

Part of the complexity may be because symfony security was based on Spring security from Java. I am not sure why Fabien chose Spring when there were good ones in the PHP world, but I hope there is a reason.

Conclusion : Symfony as a framework is nice!.
