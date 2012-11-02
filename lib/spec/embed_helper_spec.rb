require 'rubygems'
require 'embed_helper'
require 'rspec'

include Embed::EmbedHelper

describe Embed::EmbedHelper do
	let(:youtube_url) { 'http://www.youtube.com/watch?v=u1zgFlCw8Aw' }
	let(:vimeo_url)   { 'http://vimeo.com/49760839' }
	let(:soundcloud_url) { 'http://soundcloud.com/dj-slink/in-for-the-kill-dj-slinks-gets' }
	describe '::youtube_embed(url)' do
		it 'returns the embedding html for a YouTube URL' do
			youtube_embed(youtube_url, 640, 390).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0 frameborder="0"/>}
		end
	end
	describe '::youtube_embed(url, 540, 290)' do
		it 'returns the embedding html for a YouTube URL with custom sizes' do
			youtube_embed(youtube_url, 540, 290).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="540" height="290" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0 frameborder="0"/>}
		end
	end
	describe '::vimeo_embed(url)' do
		it 'returns the embedding html for a Vimeo URL' do
			vimeo_embed(vimeo_url, 640, 390).should == %Q{<iframe src="http://player.vimeo.com/video/49760839" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
		end
	end
	describe '::vimeo_embed(url, 540, 290)' do
		it 'returns the embedding html for a Vimeo URL with custom sizes' do
			vimeo_embed(vimeo_url, 540, 290).should == %Q{<iframe src="http://player.vimeo.com/video/49760839" width="540" height="290" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
		end
	end
	describe '::soundcloud_embed(url)' do
		it 'returns the embedding html for a SoundCloud URL' do
			soundcloud_embed(soundcloud_url).should == %Q{<iframe width="100%" height="166" scrolling="no" frameborder="no" src="http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F60522748&show_artwork=true"></iframe>}
		end
	end
	describe '::embed(url)' do
		it 'embeds an YouTube video' do
			embed(youtube_url).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0 frameborder="0"/>}
		end
		it 'embeds a Vimeo video' do
			embed(vimeo_url).should == %Q{<iframe src="http://player.vimeo.com/video/49760839" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
		end
		it 'embeds a SoundCloud audio' do
			embed(soundcloud_url).should == %Q{<iframe width="100%" height="166" scrolling="no" frameborder="no" src="http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F60522748&show_artwork=true"></iframe>}
		end
	end
	describe '::embed(url, 540, 290)' do
		it 'embeds an YouTube video with custom sizes' do
			embed(youtube_url, {:width => 540, :height => 290}).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="540" height="290" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0 frameborder="0"/>}
		end
		it 'embeds a Vimeo video with custom sizes' do
			embed(vimeo_url, {:width => 540, :height => 290}).should == %Q{<iframe src="http://player.vimeo.com/video/49760839" width="540" height="290" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
		end
		it 'embeds a SoundCloud audio' do
			embed(soundcloud_url).should == %Q{<iframe width="100%" height="166" scrolling="no" frameborder="no" src="http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F60522748&show_artwork=true"></iframe>}
		end
	end
end
