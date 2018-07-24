README

# TeamPay


A simple application for players to pay for the team sports games.

  - Create games
  - Google API auth/login
  - Stripe payments

# New Features!

  - Well, not so much


TODO:
  - Roles: Administrator and Player
  - Email functionality (Payment requests and confirmations/updates)
  - Slack functionality - Nice!
  - Refined features: model validations, Homepage and routes...
  - Test coverage
  - Design 101
  - Design 202
  - UX for beginners, 101

> Main thing it to fix the *TODO* in the code first.


### Tech

* [ROR] - Ruby on Rails framework
* [Ruby] - Ruby
* [Google] - Google API
* [Stripe] - Stripe

### Installation

> Install RBENV
> Ruby 2.5.1
> Bundler
> PostgreSQL
> Google API with tokens
> Stripe API with tokens

```sh
$ bundle install
$ RACK_ENV=development RAILS_ENV=development bundle exec rails db:create
$ RACK_ENV=development RAILS_ENV=development bundle exec rails db:migrate
$ RACK_ENV=development RAILS_ENV=development \
GOOGLE_CLIENT_ID=<id-here> \
GOOGLE_CLIENT_SECRET=<secret-here> \
PUBLISHABLE_KEY=<stripe-pub-key-here> \
SECRET_KEY=<stripe-secrets-here> \
TEAMPAY_ADMINS=<string-comma-seperated-list-of-email-addresses> \
bundle exec rails s
```

For test/Heroku environments...

```sh
$ 
```

For production environments...

```sh
$ 
```

License
----

MIT


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [ruby]: https://www.ruby-lang.org/en/
   [ror]: https://rubyonrails.org/
   [google]: https://console.developers.google.com/
   [stripe]: https://stripe.com/nz
