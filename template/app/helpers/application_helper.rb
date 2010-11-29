module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def action_stylesheet
    stylesheet_link_tag "#{controller.controller_name}/#{controller.action_name}" if File.exists?("#{Rails.root}/public/stylesheets/#{controller.controller_name}/#{controller.action_name}.css")
  end

  # Create a named haml tag to wrap IE conditional around a block
  # http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither
  def html_tag(attrs={}, &block)
    name = :html
    attrs.symbolize_keys!
    haml_concat("<!--[if lt IE 7 ]> #{ tag(name, add_class('ie6', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if IE 7 ]>    #{ tag(name, add_class('ie7', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if IE 8 ]>    #{ tag(name, add_class('ie8', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if IE 9 ]>    #{ tag(name, add_class('ie9', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if (gte IE 9)|!(IE)]><!-->".html_safe)
    haml_tag name, attrs do
      haml_concat("<!--<![endif]-->".html_safe)
      block.call
    end
  end

  private

  def add_class(name, attrs)
    classes = attrs[:class] || ''
    classes.strip!
    classes = ' ' + classes if !classes.blank?
    classes = name + classes
    attrs.merge(:class => classes)
  end

end