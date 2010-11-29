# rails-template

A default Rails template that includes rspec, autotest, exceptional, haml, compass, and more.

Layout views and stylesheets forked from https://github.com/sporkd/compass-html5-boilerplate.

## Recommended use

I recommend creating a fork of this project so you can personalize it.  Once you do that, run the following code, replacing `your-username` and `app-name`:

    git clone https://github.com/your-username/rails-template
    rails new app-name --template=/path/to/rails-template/base.rb

If using MySQL, don't forget to add `-d mysql` to the end of the previous line.

## vhost.rb - delete this or replace it with your own virtual host setup script

Creates a virtual host for nginx.

    sudo ruby vhost.rb app-name development-host
