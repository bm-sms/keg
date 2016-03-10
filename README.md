Keg [![Circle CI](https://circleci.com/gh/bm-sms/keg.svg?style=svg&circle-token=64f349201f5cb44f1ac47b1172626522253d20ec)](https://circleci.com/gh/bm-sms/keg)
====

Keg is CLI tool that supports a data management.

## Description
Keg use the data formatted by [TOML](https://github.com/toml-lang/toml) which is language that easy to read. 
Keg read a TOML file from the local database and outputs its useful format.
You need to clone the repository has the TOML file in the local database (`$HOME/.keg/databases`) in advance.

## VS. [glean](https://github.com/glean/glean)
glean constructs a cache in local from a specific remote repository. In contrast, Keg mainly works with the database was constructed in local. Therefore, you need to pull manually when the repository has updated. However, it run at high speed by using the data in local.

## Requirements
Ruby 2.0 higher


## Installation

Add this line to your application's Gemfile:

```sh
gem 'keg'
```

Or install it yourself as:

```sh
$ gem install keg
```

## Usage
### Preparations: 
Makes a TOML file:

```toml
# example.toml
name = 'example'
email = 'example@example.com'
```

Push this TOML file to git:

```sh
$ git add example.toml
$ git commit -m 'add example'
$ git push origin master
```

Constructs databases:

```sh
$ mkdir -p $HOME/.keg/databases
$ cd $HOME/.keg/databases 
$ git clone <your_repo> example_database
```

### Demo:

Select a database from databases in local (`$HOME/.keg/databases`):

```sh
$ keg switch example_database   #=> switch database `example_database`
```

Format and show the TOML file which is requested in the database:

```sh
$ keg show example               # show $HOME/.keg/databases/example_database/example.toml
$ keg show --format=json example # show in json format
$ keg show --format=yaml example # show in yaml format
```

Show the current database:

```sh
$ keg current                    #=> example_database
```

Format and show all TOML files in the database:

```sh
$ keg show_all                   # show all TOML file in example_database
$ keg show_all --format=json     # show all in json format
$ keg show_all --format=yaml     # show all in yaml format
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bm-sms/keg. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
