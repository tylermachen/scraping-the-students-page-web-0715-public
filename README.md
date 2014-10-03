---
tags: nokogiri, scraping, web crawling
languages: Ruby
resources: 4
---

##Scraping the Students Website
This lab is straightforward but free form scrape the [students website](http://ruby006.students.flatironschool.com/) you guys deployed to.  We're looking for you and your group (the table you're sitting at) to make a command line app that is built on top a Nokogiri scraper that will be able to accept and respond to user input.  This might mean _crawling_, moving from one website to another.  That is entering a student's name and being able to visit their profile.  What information should be available is totally up to you.  That might be a student's name.  A link to something on their profile.  Some text from a page.  Who knows?

This lab will be more free form in that it is not test driven.  So method and variable names are up to you.  The entire structure of the program is up to you.

That being said, hear are some sensible guide lines you should consider (__which don't have to be followed__):
- Keep method and variable names sensible and semantic.
  - This will come in handy when debugging and working with others.
- Use helper methods so one method isn't doing all the work.
  - The idea of helper methods is that each method should be responsible for only one thing.
  - It's okay to have a method that delegates tasks to other methods.
- Make sure you're keeping track of your data.
  - You are not going to be persisting any of the data you scrape so storing them in variables is a must.
  - Once that variable is out of scope or it's value over written it's gone.
- Try to make a class
  - It will keep your code cleaner.
  - It will facilitate the movement of variables between methods.
    - [`attr_accessor`, `attr_writer`, and `attr_reader`](http://stackoverflow.com/questions/4370960/what-is-attr-accessor-in-ruby) will be very helpful if you use a class.

Now, that you've read the guide lines feel free to disregard any or all of them as you see fit.  ___Make it work, make it right, make it fast. -[KentBeck](http://c2.com/cgi/wiki?KentBeck)___

####What you and your group must do.
One person should fork and clone this repo, creating a team repo and then everyone else clone that fork. When your team is done (done is what you decide it is) submit a pull request from the fork back to master.

###Nokogiri
Nokogiri is a ruby gem that is designed specifically for scraping websites.  Nokogiri will parse the infromation into XML nodes, which will allow you to move through the document by selecting nodes based on CSS selectors methods.

####This lab assumes you have done the assigned reading on Nokogiri, here are the links in case you need refeshing.
- [Scraping Kick Starter tutorial](https://github.com/flatiron-school-students/scraping-kickstarter-ruby-005)
- [Bastard's guide to scraping](http://ruby.bastardsbook.com/chapters/html-parsing/)
- [Nokogiri's Documentation](http://nokogiri.org/)

###Trouble Shooting Nokogiri
If you're having problems installing Nokogiri and getting an error that says `libiconv is missing`. Run `ls /usr/lib/ | grep libiconv` in your commandline and you should see something like
```
libiconv.2.4.0.dylib
libiconv.2.dylib
libiconv.dylib
```
If you don't ask a TA for help.  If you do run these three commands,
```
brew update
brew link libiconv
gem install nokogiri -- --with-iconv-dir=/usr/local/Cellar/libiconv/1.13.1
```
If those `brew link libiconv` fails ask a TA for help.
