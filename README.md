# Basic Sinatra ~v3~ v4 🥳 App with Sprockets, Warden, ActiveRecord and Postgres

Take this as a working example and as an inspiration. Pull Requests are welcome 🙏

[![ruby](https://github.com/simonneutert/sinatras-skeleton/actions/workflows/ruby.yml/badge.svg)](https://github.com/simonneutert/sinatras-skeleton/actions/workflows/ruby.yml)

### Have you tried Roda?

think sinatra is nice? Don't forget to [give Roda a chance](https://github.com/jeremyevans/roda-sequel-stack)!  
browse through my repos 😉😇

---

## What this Project aims to be

**This repository aims to be a boilerplate for a modular and modern (v4) Sinatra app.**

There used to be a demo on heroku, but heroku is no more (free of charge at least) 🪦

*Please check out the [credits](#credits) section! Without the community, this never would have been possible. Thank you.*

* [Why?](#why)
* [What is in?](#what)
* [Get started](#start)
* [Credits](#credits)

*Feel free to contribute, add more features, strip features or simply improve existing code* - __pull requests welcome__ :smile:

## <a name="why"></a>Why not Rails?

Sinatra is a ruby/rack framework, that can be used as an alternative where Rails would simply be an overkill.

I started working my way through the sinatra docs, aiming for a setup that can easily be modeled to a basic use case.

---

> Have you tried Roda, Sequel and Rodauth?  

Yes! And I totally use that setup whenever possible (November 2021) and you should try at least roda as a POC 😎 I am 100 % serious! There's nothing wrong with sinatra, but roda kills it. The journey will undoubtedly make you a better (ruby) programmer.

## <a name="what"></a>What is in?

I want this Sinatra boilerplate app to:

* work with Bundler
* use ActiveRecord as ORM
* have an MVC-like structure
* support Sass/Scss and CoffeeScript
* party with [jQuery](http://jquery.com) and [Turbolinks](https://github.com/turbolinks/turbolinks)! Yes, Turbolinks.
* rolls with a very basic bcrypt/warden based Authentication System
* use PostgresQL as Database
* run on heroku (don't forget: `$ heroku config:add APP_ENV=production`)

## <a name="start"></a>Get started
You need **Ruby (>= 3.2)** and **Bundler** (of course).

* `$ git clone`
* `$ bundle install`
* edit __config/database.yml__
* set `SESSION_SECRET` environment variable (see `.env.example`)
* `$ rake db:setup`
* `$ bundle exec puma` or `rerun rackup` ([rerun](https://github.com/alexch/rerun) gem - _not included by default!_)
* visit `localhost:9292` in your browser
* edit titles in __views/layout.erb__ and __views/nav.erb__
* check/set timezone __config/timezone.rb__

### now what?
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

**Contributors to this project**

https://github.com/simonneutert/sinatras-skeleton/graphs/contributors

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
