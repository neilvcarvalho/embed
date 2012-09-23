require 'rubygems'
require 'embed_helper'
require 'rspec'

include Embed::EmbedHelper

describe Embed::EmbedHelper do
	let(:youtube_url) { 'http://www.youtube.com/watch?v=u1zgFlCw8Aw' }
	describe '::youtube_embed(url)' do
		it 'returns the embedding html for a YouTube URL' do
			youtube_embed(youtube_url).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0 frameborder="0"/>}
		end
	end
	describe '::embed(url)' do
		it 'embeds an YouTube video' do
			embed(youtube_url).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0 frameborder="0"/>}
		end
	end
end