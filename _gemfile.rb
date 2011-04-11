# get rails version and database adapter
gemfile = File.open("Gemfile").read

regex = /
gem 'rails', '([^']+)'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git:\/\/github.com\/rails\/rails.git'

gem '([^']+)'
/

matches = regex.match(gemfile)
rails_version = matches[1]
database = matches[2]

template "Gemfile", :force => true
gsub_file "Gemfile", "[RAILS_VERSION]", rails_version
gsub_file "Gemfile", "[DATABASE]", database
