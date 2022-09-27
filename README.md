# README

## Authentication

For authentication Devise has been the choosen gem.

```
gem 'devise'
```

```
# install devise
rails g devise:install
# generate devise views in order to customize them in the future
rails g devise:views
```

Devise requires a default mailer url (localhost @ dev) in the environment.

```
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

## Mailer @ development

For development Letter Opener has been choosen, this will allow us to preview the emails in the browser instead of sending them, which is a bad practice to send emails in development.

```
group :development do
  gem 'letter_opener'
end
```

```
  config.action_mailer.delivery_method = :letter_opener
```
