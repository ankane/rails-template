# Set up rvm private gemset

# Need to strip colors in case rvm_pretty_print_flag is enabled in user"s .rvmrc
rvm_list = `rvm list`.gsub(Regexp.new("\e\\[.?.?.?m"), "")

desired_ruby = rvm_list.match(/=> ([^ ]+)/)[1]
gemset_name = @app_name

# Create the gemset
run "rvm #{desired_ruby} gemset create #{gemset_name}", :capture => true

# Let us run shell commands inside our new gemset. Use this in other template partials.
@rvm = "rvm use #{desired_ruby}@#{gemset_name}"

# Create .rvmrc
file ".rvmrc", @rvm

# Make the .rvmrc trusted
run "rvm rvmrc trust #{@app_path}", :capture => true

# Since the gemset is likely empty, manually install bundler so it can install the rest
run "#{@rvm} gem install bundler", :capture => true

# redefine run and generate
Rails::Generators::AppGenerator.send :alias_method, :orig_run, :run
Rails::Generators::AppGenerator.send :alias_method, :orig_generate, :generate

def run(*args)
  command = args.shift
  orig_run "#{@rvm} exec #{command}", *args
end

def generate(*args)
  command = args.shift
  run "rails generate #{command}", *args
end
