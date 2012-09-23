require 'embed'
require 'json'
require 'net/http'
require 'uri'
require 'cgi'

module Embed
	module EmbedHelper
		def youtube_embed(url)
			video_id = Embed.youtube_video_id(url)
			html = %Q{<iframe id="#{video_id}" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/#{video_id}?autoplay=0 frameborder="0"/>}
			html.respond_to?(:html_safe) ? html.html_safe : html
		end
		def vimeo_embed(url)
			video_id = Embed.vimeo_video_id(url)
			html = %Q{<iframe src="http://player.vimeo.com/video/#{video_id}" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
			html.respond_to?(:html_safe) ? html.html_safe : html
		end
		def soundcloud_embed(url)
			uri = URI("http://soundcloud.com/oembed")
			params = {:format => 'json', :url => url}
			uri.query = params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
			response = Net::HTTP.get(uri)
			if response
				html = JSON.parse(response)["html"]
				html.respond_to?(:html_safe) ? html.html_safe : html
			else
				return link_to(url)
			end
		end
		def embed(url)
			if url[/(youtube.com|youtu.be)/]
				return youtube_embed(url)
			elsif url[/vimeo.com/]
				return vimeo_embed(url)
			elsif url[/soundcloud.com/]
				return soundcloud_embed(url)
			end
		end
	end
end