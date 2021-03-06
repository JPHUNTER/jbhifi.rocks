###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end


activate :contentful do |f|
  f.space         = { contentful: ENV['CONTENTFUL_SPACE_ID'] }
  f.access_token  = ENV['CONTENTFUL_API_KEY']
  f.cda_query     = { content_type: ENV['CONTENTFUL_CONTENT_TYPE'], include: 1 }
  f.content_types = { product: ENV['CONTENTFUL_CONTENT_TYPE']}
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

if data.respond_to? :contentful
  data.contentful.product.each do |elem|
    p = elem[1]
    proxy "products/#{p.slug}.html", "product.html", locals: { product: p }, ignore: true
  end
end

helpers do
  def snipcart_button (p, text)
    args = {
        "class" => "snipcart-add-item button expanded crazy-font",
        "data-item-id" => p.id,
        "data-item-price" => p.price,
        "data-item-name" => p.productName,
        "data-item-url" => current_page.url,
        "data-item-max-quantity" =>  p.quantity,
        "data-item-description" => p.productDescription,
        "data-item-image" => "http:#{p.image.first.url}"
    }
    content_tag :button, args do
      text
    end
  end
end

helpers do
  def snipcart_button_small (p, text)
    args = {
        "class" => "snipcart-add-item button small expanded crazy-font",
        "data-item-id" => p.id,
        "data-item-price" => p.price,
        "data-item-name" => p.productName,
        "data-item-url" => current_page.url,
        "data-item-max-quantity" =>  p.quantity,
        "data-item-description" => p.productDescription,
        "data-item-image" => "http:#{p.image.first.url}"
    }
    content_tag :button, args do
      text
    end
  end
end

helpers do
  def snipcart_button_xsmall (p, text)
    args = {
        "class" => "snipcart-add-item button x-small expanded crazy-font",
        "data-item-id" => p.id,
        "data-item-price" => p.price,
        "data-item-name" => p.productName,
        "data-item-url" => current_page.url,
        "data-item-max-quantity" =>  p.quantity,
        "data-item-description" => p.productDescription,
        "data-item-image" => "http:#{p.image.first.url}"
    }
    content_tag :button, args do
      text
    end
  end
end
