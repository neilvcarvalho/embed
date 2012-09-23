require 'embed'

module Embed
	module EmbedHelper
		def youtube_embed(url)
			video_id = Embed.youtube_video_id(url)
			%Q{<iframe id="#{video_id}" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/#{video_id}?autoplay=0 frameborder="0"/>}
		end
		def embed(url)
			if url[/(youtube.com|youtu.be)/]
				return youtube_embed(url)
			end
		end
	end
end