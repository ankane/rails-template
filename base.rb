# setup paths
base_dir = File.dirname __FILE__
source_dir = "#{base_dir}/template"
source_paths.unshift source_dir

apply "#{base_dir}/_gemfile.rb"
apply "#{base_dir}/_rvm.rb"

run "bundle install"

# compass
run "compass init rails --sass-dir app/stylesheets --css-dir tmp/stylesheets --prepare", :capture => true

# rspec
remove_dir "test"
generate "rspec:install"
file ".autotest", <<-CONF
require "autotest/fsevent"
require "autotest/growl"
CONF
append_file ".rspec", <<-CONF
--format documentation
CONF

# heroku
gsub_file "config/environments/production.rb", "config.serve_static_assets = false", "config.serve_static_assets = true"

# remove unnecessary files
remove_file "README"
remove_file "app/views/layouts/application.html.erb"
inside "public" do
  remove_file "index.html"
  remove_file "images/rails.png"
end
inside "public/javascripts" do
  run "rm *"
end

# create a default controller
generate "controller home index"
route "root :to => \"home#index\""

# add files in template that match *.*
files = Dir["#{source_dir}/**/*.*"]
files.each do |f|
  f.gsub! "#{source_dir}/", ""
  template f, :force => true
end

run "rake -s db:create && rake -s db:migrate", :capture => true

# git
git :init => "-q"
git :add => ".", :commit => "-q -m 'Initial commit'"
