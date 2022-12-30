require "embed"
require "net/http"
require "json"

module Embed
  module EmbedHelper
    def _youtube_embed(url, width, height)
      html = %(<iframe id="#{Embed.video_id(url)}" src="#{Embed.video_url(url)}?autoplay=0&rel=0" type="text/html" width="#{width}" height="#{height}" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"></iframe>)
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    def _vimeo_embed(url, width, height)
      html = %(<iframe id="#{Embed.video_id(url)}" src="#{Embed.video_url(url)}" width="#{width}" height="#{height}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>)
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    def _facebook_embed(url, width, height)
      html = %(<iframe id="#{Embed.video_id(url)}" src="#{Embed.video_url(url)}&width=#{width}&show_text=0" width="#{width}" height="#{height}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>)
      html.respond_to?(:html_safe) ? html.html_safe : html
    end

    def _soundcloud_embed(url)
      params = {format: "json", url: url}
      _oembed("https://soundcloud.com/oembed", url, params)
    end

    def _wistia_embed(url, width, height)
      params = {format: "json", url: url, width: width, height: height}
      _oembed("https://fast.wistia.com/oembed", url, params)
    end

    def _oembed(oembed_url, url, params)
      uri = URI(oembed_url)
      uri.query = params.collect { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.join("&")
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
      return if url.nil? || url.empty?

      params[:width] ||= 640
      params[:height] ||= 390
      if url[/(youtube\.com|youtu\.be)/]
        _youtube_embed(url, params[:width], params[:height])
      elsif url[/vimeo\.com/]
        _vimeo_embed(url, params[:width], params[:height])
      elsif url[/soundcloud\.com/]
        _soundcloud_embed(url)
      elsif url[/wistia\.com/]
        _wistia_embed(url, params[:width], params[:height])
      elsif url[/facebook\.com/]
        _facebook_embed(url, params[:width], params[:height])
      end
    end
  end
end
