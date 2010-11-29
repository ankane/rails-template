Haml::Template.options[:attr_wrapper] = '"'
Sass::Plugin.options[:line_comments] = false
if Rails.env.production?
   Sass::Plugin.options[:never_update] = true
end