# rails-template

A Rails template that includes rspec, autotest, exceptional, haml, compass, and more.

Some views, stylesheets, and helper functions were forked from https://github.com/sporkd/compass-html5-boilerplate.

## Fork this project so you can personalize it!

Then, clone the fork to your development machine.

    git clone https://github.com/your-username/rails-template

To create a new project with your template, run:

    rails new app-name --template=/path/to/rails-template/base.rb

If using MySQL, don't forget to add `-d mysql` to the end of the previous line.

## How it works

After a standard Rails 3 project is created, `base.rb` is executed.

All files in the `template` directory - *except those that begin with . (dot)* - are copied into the new project, overwriting original files when conflicts occur.

## vhost.rb - delete this or replace it with your own virtual host setup script

Creates a virtual host for nginx.

    sudo ruby vhost.rb app-name development-host
