module PostsHelper

  require 'embedly'
  require 'json'


	def embedly(post)
	@post = post
	embedly_api = Embedly::API.new :key => 'be7f3a535a974297b014470a23243df4'
    obj = embedly_api.oembed :url => @post.url

    @post.title = obj[0].title
    @post.embed_code = obj[0].html
    @post.description =  obj[0].description
    @post.thumbnail = obj[0].thumbnail_url
    @post.provider = obj[0].provider_name || ""
    @post.provider_url = obj[0].provider_url
    @post.author = obj[0].author_name || ""
    @post.author_url = obj[0].author_url

	end
end
