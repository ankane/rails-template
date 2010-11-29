exceptional_key = ask("Exceptional API key:")
exceptional = !exceptional_key.blank?
rspec = true #yes?("Install rspec?")
heroku = true #yes?("Use heroku?")

gem "haml"
gem "haml-rails"
gem "compass"

if exceptional
  gem "exceptional"
end

if rspec
  gem "rspec"
  gem "rspec-rails"
  gem "autotest"
  gem "autotest-fsevent"
  gem "autotest-growl"
end

if heroku
  gem "heroku", :group => :development
  gsub_file "config/environments/production.rb", "config.serve_static_assets = false", "config.serve_static_assets = true"
end

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
if rspec
  run "rm -r test"
  run "rails g rspec:install"
  file ".autotest", <<-CONF
require "autotest/fsevent"
require "autotest/growl"
CONF

  append_file ".rspec", <<-CONF
--format documentation
CONF
end

run "touch public/javascripts/application.js"
run "echo 'TODO add readme content' > README"

generate "controller home index"
route "root :to => \"home#index\""

# add template
source_dir = "#{File.dirname(__FILE__)}/template"
source_paths.unshift(source_dir)

files = Dir["#{source_dir}/**/*.*"]
files.each do |f|
  f.gsub!("#{source_dir}/", "")
  template f, :force => true
end

run "rake -s db:create"
run "rake -s db:migrate"

# git
git :init => "-q"
git :add => ".", :commit => "-m 'Initial commit' -q"