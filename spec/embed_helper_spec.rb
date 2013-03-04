require 'rubygems'
require 'embed_helper'
require 'rspec'

include Embed::EmbedHelper

describe Embed::EmbedHelper do
  let(:youtube_url) { 'http://www.youtube.com/watch?v=u1zgFlCw8Aw' }
  let(:vimeo_url)   { 'http://vimeo.com/49760839' }
  let(:soundcloud_url) { 'http://soundcloud.com/forss/flickermood' }
  let(:wistia_url) { 'http://fast.wistia.com/embed/iframe/2cf8fbb2c0' }

  describe '::_youtube_embed(url, 640, 390)' do
    it 'returns the embedding html for a YouTube URL' do
      _youtube_embed(youtube_url, 640, 390).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0" frameborder="0"></iframe>}
    end
  end

  describe '::_vimeo_embed(url, 640, 390)' do
    it 'returns the embedding html for a Vimeo URL' do
      _vimeo_embed(vimeo_url, 640, 390).should == %Q{<iframe src="http://player.vimeo.com/video/49760839" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
    end
  end

  describe '::_soundcloud_embed(url)' do
    it 'returns the embedding html for a SoundCloud URL' do
      _soundcloud_embed(soundcloud_url).should == %Q{<iframe width=\"100%\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F293&show_artwork=true\"></iframe>}
    end
  end

  describe '::_wistia_embed(url, 640, 390)' do
    it 'returns the embedding html for a Wisita URL' do
      _wistia_embed(wistia_url, 640, 390).should == %Q{<iframe src="http://fast.wistia.com/embed/iframe/2cf8fbb2c0?version=v1&videoHeight=360&videoWidth=640" allowtransparency="true" frameborder="0" scrolling="no" class="wistia_embed" name="wistia_embed" width="640" height="390"></iframe>}
    end
  end

  describe '::embed(url)' do
    it 'embeds an YouTube video' do
      embed(youtube_url).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0" frameborder="0"></iframe>}
    end

    it 'embeds a Vimeo video' do
      embed(vimeo_url).should == %Q{<iframe src="http://player.vimeo.com/video/49760839" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
    end

    it 'embeds a SoundCloud audio' do
      embed(soundcloud_url).should == %Q{<iframe width=\"100%\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F293&show_artwork=true\"></iframe>}
    end
  end

  describe '::embed(url, 540, 290)' do
    it 'embeds an YouTube video with custom sizes' do
      embed(youtube_url, {:width => 540, :height => 290}).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="540" height="290" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0" frameborder="0"></iframe>}
    end

    it 'embeds a Vimeo video with custom sizes' do
      embed(vimeo_url, {:width => 540, :height => 290}).should == %Q{<iframe src="http://player.vimeo.com/video/49760839" width="540" height="290" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
    end

    #FIXME: Wistia always return videoHeight=360&videoWidth=640 ??
    it 'embeds a Wistia video with custom sizes' do
      embed(wistia_url, {:width => 540, :height => 290}).should == %Q{<iframe src="http://fast.wistia.com/embed/iframe/2cf8fbb2c0?version=v1&videoHeight=360&videoWidth=640" allowtransparency="true" frameborder="0" scrolling="no" class="wistia_embed" name="wistia_embed" width="540" height="290"></iframe>}
    end

    it 'embeds a SoundCloud audio' do
      embed(soundcloud_url).should == %Q{<iframe width=\"100%\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F293&show_artwork=true\"></iframe>}
    end
  end
end
