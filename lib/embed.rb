require "embed/version"
require "embed_helper"
require "digest"

module Embed
  def self.video_site(url)
    case url.to_s.downcase
    when /(youtube.com|youtu.be)/
      :youtube
    when /vimeo.com/
      :vimeo
    when /soundcloud.com/
      :soundcloud
    when /wistia.com/
      :wistia
    when /facebook.com/
      :facebook
    end
  end

  def self.video_url(url, protocol = nil)
    if protocol
      warn "Embed.video_url(url, protocol) is deprecated and a future release will only use \"https\"."
    end
    protocol ||= "https"

    case Embed.video_site(url)
    when :youtube
      video_id = Embed.youtube_video_id(url)
      "#{protocol}://www.youtube.com/embed/#{video_id}"
    when :vimeo
      video_id = Embed.vimeo_video_id(url)
      "#{protocol}://player.vimeo.com/video/#{video_id}"
    when :facebook
      "#{protocol}://www.facebook.com/plugins/video.php?href=" + URI.encode_www_form_component(url)
    else
      url
    end
  end

  def self.video_id(url)
    case Embed.video_site(url)
    when :youtube
      "youtube-#{youtube_video_id(url)}"
    when :vimeo
      "vimeo-#{vimeo_video_id(url)}"
    else
      "#{Embed.video_site(url)}-#{Digest::SHA1.hexdigest(url)}"
    end
  end

  def self.youtube_video_id(url)
    if url[%r{^.*((/v/)|(embed/)|(watch\?))\??v?=?([^&?]*).*}]
      $5
    elsif url[%r{youtube\.com/shorts/([^/?]*)/?}i] || url[%r{youtu\.be/([^/?]*)/?}i]
      $1
    end
  end

  def self.vimeo_video_id(url)
    if url[/vimeo.com\/([^?]*)/]
      $1
    end
  end
end

if defined?(ActionView::Base)
  ActionView::Base.send :include, Embed::EmbedHelper
end
