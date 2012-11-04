require 'embed'
require 'json'
require 'net/http'
require 'uri'
require 'cgi'

module Embed
  module EmbedHelper
    def _youtube_embed(url, width, height)
      video_id = Embed.youtube_video_id(url)
      html = %Q{<iframe id="#{video_id}" type="text/html" width="#{width}" height="#{height}" src="http://www.youtube.com/embed/#{video_id}?autoplay=0 frameborder="0"/>}
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    def _vimeo_embed(url, width, height)
      video_id = Embed.vimeo_video_id(url)
      html = %Q{<iframe src="http://player.vimeo.com/video/#{video_id}" width="#{width}" height="#{height}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    def _soundcloud_embed(url)
      params = {:format => 'json', :url => url}
      _oembed('http://soundcloud.com/oembed', url, params)
    end

    def _wistia_embed(url, width, height)
      params = { :format => 'json', :url => url, :width => width, :height => height }
      _oembed('http://fast.wistia.com/oembed', url, params)
    end

    def _oembed(oembed_url, url, params)
      uri = URI(oembed_url)
      uri.query = params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
      response = Net::HTTP.get(uri)
      if response
        begin
          html = JSON.parse(response)["html"]
          html.respond_to?(:html_safe) ? html.html_safe : html
        rescue JSON::ParserError
          defined?(link_to) ? link_to(url) : url
        end
      else
        defined?(link_to) ? link_to(url) : url
      end
    end

    def embed(url, params = {})
      params[:width] ||= 640
      params[:height] ||= 390
      if url[/(youtube.com|youtu.be)/]
        return _youtube_embed(url, params[:width], params[:height])
      elsif url[/vimeo.com/]
        return _vimeo_embed(url, params[:width], params[:height])
      elsif url[/soundcloud.com/]
        return _soundcloud_embed(url)
      elsif url[/wistia.com/]
        return _wistia_embed(url, params[:width], params[:height])
      end
    end
  end
end
