require 'embed'

module Embed
	module EmbedHelper
		def youtube_embed(url)
			video_id = Embed.youtube_video_id(url)
			url = %Q{<iframe id="#{video_id}" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/#{video_id}?autoplay=0 frameborder="0"/>}
			url.respond_to?(:html_safe) ? url.html_safe : url
		end
		def vimeo_embed(url)
			video_id = Embed.vimeo_video_id(url)
			url = %Q{<iframe src="http://player.vimeo.com/video/#{video_id}" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
			url.respond_to?(:html_safe) ? url.html_safe : url
		end
		def embed(url)
			if url[/(youtube.com|youtu.be)/]
				return youtube_embed(url)
			elsif url[/vimeo.com/]
				return vimeo_embed(url)
			end
		end
	end
end