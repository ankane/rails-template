# rails-template

A Rails template that includes rspec, autotest, exceptional, haml, compass, and more.

Some views, stylesheets, and helper functions were forked from https://github.com/sporkd/compass-html5-boilerplate.

## Fork this project so you can personalize it

Then, clone the fork to your development machine.

    git clone https://github.com/your-username/rails-template

To create a new project with your template, run:

    rails new app-name -d mysql -m /path/to/rails-template/base.rb

## How it works

After a standard Rails 3 project is created, `base.rb` is executed.

All files in the `template` directory that match `*.*` are copied into the new project, overwriting original files when conflicts occur.

## Install more gems

### Exceptional

Add to Gemfile

    gem "exceptional"

Run

    exceptional install API-KEY
    exceptional test

### Devise

Add to Gemfile

    gem "devise"

Add to development group in Gemfile

    gem "erb2haml"

Run

    rails g devise:install
    rails g devise User
    rails g devise:views -e erb
    rake haml:convert_erbs
