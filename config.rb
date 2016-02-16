###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# General configuration

config[:site_title] = 'Fieldstone Landscape Development'
config[:title_delimiter] = '  |  '

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

	def files_from_dir( source_dir, build_dir = nil )
		dir = "source/#{source_dir}"
		build_dir ||= source_dir
		files = []
		if Dir.exists? dir
			files = Dir.entries(dir).
				select { |f| !File.directory? f }.
				map { |f| File.join(build_dir, f) }
		end
		files
	end

	def images_from_dir( source_dir, build_dir=nil )
		accepted_ext = ['.png', '.jpg']
		files_from_dir( source_dir, build_dir ).select do |f|
			accepted_ext.include? File.extname f
		end
	end

	def page_images
		accepted_ext = ['.png', '.jpg']
		page_dir = current_page.path.sub('.html', '')
		images_from_dir( page_dir, current_page.url ).select do |f|
			accepted_ext.include? File.extname f
		end
	end

end

# Build-specific configuration
configure :build do
	activate :minify_css
	activate :minify_javascript
	activate :cache_buster
	activate :gzip
end
