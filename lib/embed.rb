require "embed/version"
require 'embed_helper'

module Embed
	def self.youtube_video_id(url)
		if url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
			return $5
		elsif url[/youtu\.be\/([^\?]*)/]
			return $1
		end
	end
	def self.vimeo_video_id(url)
		if url[/vimeo.com\/([^\?]*)/]
			return $1
		end
	end
end

if defined?(ActionView::Base)
	ActionView::Base.send :include, Embed::EmbedHelper
end