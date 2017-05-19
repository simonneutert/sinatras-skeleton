# Basic Sinatra App with Sprockets, Warden, ActiveRecord and PostgresQL

**This repository aims to be a boilerplate for a modular 2017 Sinatra (v2) app.**

[demo on heroku](https://sinatras-skeleton.herokuapp.com) (admin area is locked up :wink:)

*please check out the [credits](#credits) section! Without the community, this never would have been possible. Thank you.*

* [Why?](#why)
* [What is in?](#what)
* [Get started](#start)
* [Credits](#credits)

*Feel free to contribute, add more features, strip features or simply improve existing code* - __pull requests welcome__ :smile:

## <a name="why"></a>Why?
Why not Rails?

Sinatra is a ruby/rack framework, that can be used as an alternative where Rails would simply be an overkill (though Rail5 really lost weight).

I started working my way through the sinatra docs, aiming for a setup that can easily be modeled to a basic use case.

## <a name="what"></a>What is in?

I want this Sinatra boilerplate app to:

* work with Bundler
* use ORM is ActiveRecord
* have an MVC-like structure
* support Sass/Scss and CoffeeScript
* brings [jQuery](http://jquery.com) and [Turbolinks](https://github.com/turbolinks/turbolinks)! Yes, Turbolinks.
* roll an Authentication System
* use PostgresQL as Database
* run locally
* run on heroku (don't forget: `$ heroku config:add APP_ENV=production`)


## <a name="start"></a>Get started
You need **Ruby (2.3.3)**, **Bundler**  installed.

_If you do not have a local PostgresQL DB running, heroku can handle the code as is - do not forget to add **Heroku PostgresQL** addon in your dashboard._

* `$ git clone`
* `$ bundle install`
* edit __config/database.yml__
* `$ rake db:setup`
* `$ thin start` or `shotgun` ([shoutgun](https://github.com/rtomayko/shotgun) gem - _not included by default!_)
* edit titles in __views/layout.haml__ and __views/nav.haml__
* check/set timezone __config/timezone.rb__



### now what?
* read this readme
* read the credits
* read the code
* run the code, see what it does
* delete what you don't need and built from there, should a barebone branch be offered? What do you think? :grin:

Most code is commented, so you'll learn what it does.

### What needs to be done
* enable flash messages, especially for validation feedback

## Contribute
* Send in pull requests, improve this project with features or **simply by adding/improving comments** :grin:
* Be nice, make public forks
* What did you use this app for? Please, let me know! Share your projects.

## <a name="credits"></a>Credits / Blood, Sweat & Tears
:heart: :sweat: :sob:

thank you for open sourcing, writing documentation, blogging, answering and giving a hand on stackoverflow :thumbsup:

**Warden**

[sklises repo](https://github.com/sklise/sinatra-warden-example)

[Steve Klise Blog post](https://sklise.com/2013/03/08/sinatra-warden-auth/)

[Coderwall on Sinatra + Warden](https://coderwall.com/p/ellbgw/sinatra-authentication-with-warden)

[What Ches wrote up](https://gist.github.com/ches/243611)

[What Mike Ebert wrote](http://mikeebert.tumblr.com/post/27097231613/wiring-up-warden-sinatra)

**ActiveRecord + PostgresQL**

[mherman](http://mherman.org/blog/2013/06/08/designing-with-class-sinatra-plus-postgresql-plus-heroku/#.WKrnsxiX_-k)

[samuelstern](https://samuelstern.wordpress.com/2012/11/28/making-a-simple-database-driven-website-with-sinatra-and-heroku/)

**BCrypt**

[Kieran's Answer on StackOverflow](http://stackoverflow.com/questions/39525723/bcrypterrorsinvalidhash-error-in-rails/39526561#39526561)

[BCrypt Gem](https://github.com/codahale/bcrypt-ruby#how-to-use-bcrypt-ruby-in-general)

**Sprockets**

[Sinatra Recipe for Sprockets](http://recipes.sinatrarb.com/p/asset_management/sprockets)

**Official Sinatra Docs**

[Sinatra Intro](http://www.sinatrarb.com/intro.html)

[Sinatra recipes](http://recipes.sinatrarb.com/)
