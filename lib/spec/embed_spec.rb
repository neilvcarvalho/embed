require 'rubygems'
require 'embed'
require 'rspec'

include Embed

describe Embed do
	describe '::youtube_video_id(url)' do
		it 'returns the YouTube video code from a full URL' do
			url = 'http://www.youtube.com/watch?v=dMH0bHeiRNg'
			Embed.youtube_video_id(url).should == 'dMH0bHeiRNg'
		end
		it 'returns the YouTube video code from a short URL' do
			url = 'http://youtu.be/dMH0bHeiRNg'
			Embed.youtube_video_id(url).should == 'dMH0bHeiRNg'
		end
	end
end