exceptional_key = ask("Exceptional API key:")
exceptional = !exceptional_key.blank?

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

# add source dir
source_dir = "#{File.dirname(__FILE__)}/template"
source_paths.unshift(source_dir)

template "Gemfile", :force => true
gsub_file "Gemfile", "[RAILS_VERSION]", rails_version
gsub_file "Gemfile", "[DATABASE]", database

if !exceptional
  # remove from Gemfile
  ex = <<-GEMFILE
gem "exceptional"

GEMFILE
  gsub_file "Gemfile", ex, ""
end

# heroku
gsub_file "config/environments/production.rb", "config.serve_static_assets = false", "config.serve_static_assets = true"

run "bundle update", :capture => true

if exceptional
  run "exceptional install #{exceptional_key}"
  run "exceptional test"
end

run "compass init rails --sass-dir app/stylesheets --css-dir public/stylesheets --prepare", :capture => true

# remove unnecessary files
run "rm public/index.html"
run "rm public/images/rails.png"
run "rm app/views/layouts/application.html.erb"
run "rm public/javascripts/*"
run "rm README"

# rspec
run "rm -r test"
run "rails g rspec:install"
file ".autotest", <<-CONF
require "autotest/fsevent"
require "autotest/growl"
CONF
append_file ".rspec", <<-CONF
--format documentation
CONF

# create a default controller
generate "controller home index"
route "root :to => \"home#index\""

# add files in template that match *.*
files = Dir["#{source_dir}/**/*.*"]
files.each do |f|
  f.gsub!("#{source_dir}/", "")
  template f, :force => true
end

run "rake -s db:create"
run "rake -s db:migrate"

# git
git :init => "-q"
git :add => ".", :commit => "-q -m 'Initial commit'"