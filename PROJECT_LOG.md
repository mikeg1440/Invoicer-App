# Log

## Idea

  THis is a app for freelancers/business's to create a list of clients and create invoices for the clients that can then be viewed by the client.

  #### MVP
  We should be able to
  - create a user
  - create a client after logging in
  - create a invoice and select client from list
  - when creating a client automatically create a new user for that client
  - allow clients to only view their invoices
  - allow clients to accept invoices
  - users should be able to edit their own settings
  - users should be able to edit their own invoices/ but not customers
  - allow admins

  ##### Extended Features
  - Email invoices to clients (with credentials if a new client)
  - notify users of accepted invoices
  - allow users to create groups?

## Setup
 - `rails new invoicer -d=postgresql --webpack`

## Postgresql
 - add `gem 'dotenv-rails', groups: [:development, :test]` to top of Gemfile
 - `bundle`
 - add this to the `config/application.rb` file between rails include and Bundler.require
 ```
 Bundler.require(*Rails.groups)
 Dotenv::Railtie.load
```
 - #### Create postgresql user
  - `sudo su postgres`
  - `psql`
  - should create a new user (look it up)
  - `\password` to set a new password
  - possibly a role too not sure
  - put db user and pass in the `.env` file
 - #### Modify `config/database.yml` file to work properly
  - should use `<%= ENV['INVOICER_DATABASE_USER'] %>` for db username in `.env` file
  - use `<%= ENV['INVOICER_DATABASE_PASSWORD'] %>` for password in `.env` file
  - set `host: localhost` for each database entry (dev, test, prod)

## Devise
 - add `devise` to Gemfile
 - `bundle`
 - `rails g devise:install`
 - `rails g devise user`
 - `rails db:migrate`

## Edit create & edit migrations
 - Uncomment anything that you want to include from devise generated migration
 -  `rails g model client name email phone_numer address user_id:integer  -
-no-fixture`
 - `rails g model invoice amount_due:integer client_id:integer due_time:da
tetime --no-fixture`
 - `rails g model product name description:text quantity:integer price:int
eger invoice_id:integer --no-fixture`
 - run migrations

## Add rake task to rebuild db
 - generate task using `rails g task db dcms` to drop,create, migrate, seed our db

## Add faker gem and create seed file
 - Use faker gem to generate fake data for the db in our seed file

 
