require 'embed'
require 'json'
require 'net/http'
require 'uri'
require 'cgi'

module Embed
	module EmbedHelper
		def youtube_embed(url, width, height)
			video_id = Embed.youtube_video_id(url)
			html = %Q{<iframe id="#{video_id}" type="text/html" width="#{width}" height="#{height}" src="http://www.youtube.com/embed/#{video_id}?autoplay=0 frameborder="0"/>}
			html.respond_to?(:html_safe) ? html.html_safe : html
		end
		def vimeo_embed(url, width, height)
			video_id = Embed.vimeo_video_id(url)
			html = %Q{<iframe src="http://player.vimeo.com/video/#{video_id}" width="#{width}" height="#{height}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
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
                def wistia_embed(url, width, height)
                        uri = URI('http://fast.wistia.com/oembed')
                        params = { :format => 'json', :url => url, :width => width, :height => height }
                        uri.query = params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
                        response = Net::HTTP.get(uri)
                        if response
                                html = JSON.parse(response)["html"]
                                html.respond_to?(:html_safe) ? html.html_safe : html
                        else
                                return link_to(url)
                        end
                end
		def embed(url, params = {})
                        params[:width] ||= 640
                        params[:height] ||= 390
			if url[/(youtube.com|youtu.be)/]
				return youtube_embed(url, params[:width], params[:height])
			elsif url[/vimeo.com/]
				return vimeo_embed(url, params[:width], params[:height])
			elsif url[/soundcloud.com/]
				return soundcloud_embed(url)
			elsif url[/wistia.com/]
				return wistia_embed(url, params[:width], params[:height])
			end
		end
	end
end
