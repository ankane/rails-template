# Set up rvm private gemset

# Need to strip colors in case rvm_pretty_print_flag is enabled in user"s .rvmrc
rvm_list = `rvm list`.gsub(Regexp.new("\e\\[.?.?.?m"), "")

desired_ruby = rvm_list.match(/=> ([^ ]+)/)[1]
gemset_name = @app_name

# Create the gemset
run "rvm #{desired_ruby} gemset create #{gemset_name}"

# Let us run shell commands inside our new gemset. Use this in other template partials.
@rvm = "rvm use #{desired_ruby}@#{gemset_name}"

# Create .rvmrc
file ".rvmrc", @rvm

# Make the .rvmrc trusted
run "rvm rvmrc trust #{@app_path}", :capture => true

# Since the gemset is likely empty, manually install bundler so it can install the rest
run "#{@rvm} gem install bundler", :capture => true

# Install all other gems needed from Gemfile
run "#{@rvm} exec bundle install"

