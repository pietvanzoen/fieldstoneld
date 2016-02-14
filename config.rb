###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
	activate :livereload
end

activate :directory_indexes

activate :blog do |blog|
	blog.name = 'portfolio'
	blog.layout = 'portfolio'
	blog.sources = 'portfolio/{year}-{month}-{day}-{title}.html'
	blog.permalink = 'portfolio/{title}.html'
end

activate :deploy do |deploy|
	deploy.build_before = true
	deploy.deploy_method = :git
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
	def nav_link(link, url, opts={})
		if current_resource.url == url_for(url)
			opts[:class] = "current"
		end
		link_to(link, url, opts)
	end

	def page_files
		dir = "source/#{current_page.path.sub('.html', '')}"
		files = []
		if Dir.exists? dir
			files = Dir.entries(dir).
				select { |f| !File.directory? f }.
				map { |f| "#{current_page.url}#{f}"}
		end
		files
	end

	def page_images
		accepted_ext = ['.png', '.jpg']
		page_files.select do |f|
			accepted_ext.include? File.extname f
		end
	end

	def portfolio_images
		page_images.reject do |f|
			f.include? 'matrix.jpg'
		end
	end

end

# Build-specific configuration
configure :build do
	activate :minify_css
	activate :minify_javascript
end
