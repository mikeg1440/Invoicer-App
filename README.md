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

One Paragraph of project description goes here

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

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

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```


## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
