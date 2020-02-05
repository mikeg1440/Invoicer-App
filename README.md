```

 _                 _                      _______             
| |               (_)                    (_______)            
| |____ _   _ ___  _  ____ _____  ____    _______ ____  ____  
| |  _ \ | | / _ \| |/ ___) ___ |/ ___)  |  ___  |  _ \|  _ \
| | | | \ V / |_| | ( (___| ____| |      | |   | | |_| | |_| |
|_|_| |_|\_/ \___/|_|\____)_____)_|      |_|   |_|  __/|  __/
                                                 |_|   |_|    
```
# README

## Contents
 - [ ] [Description](#description)
 - [ ] [Installing](#installing)
 - [ ] [Prerequisites](#prerequisites)
 - [ ] [Running the tests](#running-the-tests)
 - [ ] [Built With](#build-with)
 - [ ] [License](#license)
 - [ ] [Contributing](#contributing)
 - [ ] [Future Features](#future-features)

## Description

Ruby on Rails application using OO and MVC patterns that allows users to create/edit/view invoices and email them to clients with the ability for clients to accept or decline the invoice which updates the status in dashboard. Programmed with Github OAuth sign in functionality to allow users to sign in with their existing Github account.
## Getting Started

 1. Clone the repo with this command `git clone https://github.com/mikeg1440/Invoicer-App`
 2. Configure your PostgreSQL installation and set users credentials/permissions see [here for instruction](https://wiki.postgresql.org/wiki/First_steps)
 3. Run migrations (see installation section)
 4. Create a free [SendGrid account](https://signup.sendgrid.com/) and copy config details.
 5. Configure action mailer with [sendgrid access](https://sendgrid.com/docs/for-developers/sending-email/rubyonrails/) 
 6. Configure access to Github API if you want to use GitHub OmniAuth login  
 4. Run rails server `rails s`


### Prerequisites

 - Ruby on Rails 
 - PostgreSQL 
 - Credential management (I used DotENV gem for this)
```
Give examples
```

### Installing

  Need to set up postgresql db first
   - `sudo su postgres`
   - `psql`
   - `\password` then enter password twice
   - add a `.env` file to root directory and set the db password like this `DATABASE_PASSWORD=<DB_PASSWORD_HERE>`

  #### NOTE - if you get a message about yarn integrity not found or something similar then you can fix it by adding this line `config.webpacker.check_yarn_integrity = false` to the `/config/environments/development.rb` file, I put it at the bottom but idk if it matters.

  Now we need to create the db before we can run migrations
   - `rails db:create`
   - `rails db:migrate`
   -  if you want to test then seed the db `rails db:seed`
   - then to run tests do `rspec`

 
## Project Todo List

 - Add additional OmniAuth options
 - Restrict access of client information for users (only users that created clients can view those clients)
 - Fix formatting of email so that it looks just like the HTML rendering of invoice


## Built With

* [OmniAuth Gem](https://github.com/omniauth/omniauth) - Authentication system
* [Ruby on Rails](https://rubyonrails.org/) - Ruby framework
* [DotENV](https://github.com/bkeepers/dotenv) - Used to manage environmental variables

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
