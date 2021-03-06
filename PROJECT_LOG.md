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
 - `rails g devise:views`

## Edit create & edit migrations
 - Uncomment anything that you want to include from devise generated migration (add email, make unique, uncomment others)
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
 - run `rails c` to check and verify all relationships work properly

## Create tests
 - Validate data and relationships with rspec test files
 - We should have specified rspec in the beggining to save some work
 - Delete all the entire `test` dir in root directory
 - Add these gems to Gemfile in `:test` namespace group
  - `gem 'rspec-rails', '~> 3.5'`
  - `gem 'factory_girl_rails'`
  - `gem 'database_cleaner'`
 - run `bundle`
 - run `rails g rspec:install` to install rspec framework
 - add `require 'database_cleaner'` and `require 'capybara/rspec'` below `require rspec/rails` in `spec/rails_helper.rb` file
 - change `config.use_transactional_fixtures` to false
 - Add code from [this site](https://medium.com/@amliving/my-rails-rspec-set-up-6451269847f9) to `rails_helper.rb`
 - Remove `config.fixture_path = "#{::Rails.root}/spec/fixtures"` cause we're not using it
 - Add `config.include FactoryGirl::Syntax::Methods` to the `Rspec.configure` block
 - Add `config.include Devise::Test::ControllerHelpers, type: :controller` in same block for devise testing
 - Add `-f documentation` and `--f-f` to `.rspec` file for better test displays
 - create some tests


## Notes 12/3

  Started off the day getting devise to work properly and using only what I needed but this ended up being too time consuming so I abandoned that branch, created a new and started fresh with a full devise install only modifying enough to get things working properly.  Next I set up incorporated bootstrap 4 the proper way using ruby instead of the cdn this time.  From there I went on to create the client controller and views which took up most of the afternoon.

## Notes 12/4

## Notes 12/5

  Need to add somethings on that we forgot in the beggining
  - Add attributes to user model
   - add business name
   - add first and last name
   - add address, city state zip
  - Add expand attributes for client model
   - Break up address to multiple fields (street, city, state, zip)

  Created the account view and client view as well as the invoice with nested forms for invoice_products, struggled with getting github omni auth set but got it done eventually.  

  Next added some styling and finish formatting some forms for client and account views.  
