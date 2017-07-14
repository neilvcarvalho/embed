require 'rubygems'
require 'embed_helper'
require 'rspec'

include Embed::EmbedHelper

describe Embed::EmbedHelper do
  let(:youtube_url) { 'http://www.youtube.com/watch?v=u1zgFlCw8Aw' }
  let(:vimeo_url)   { 'http://vimeo.com/49760839' }
  let(:soundcloud_url) { 'http://soundcloud.com/forss/flickermood' }
  let(:wistia_url) { 'http://fast.wistia.com/embed/iframe/2cf8fbb2c0' }
  let(:facebook_url) { 'https://www.facebook.com/Facebook360/videos/1681464425405359/' }

  describe '::_youtube_embed(url, 640, 390, http)' do
    it 'returns the embedding html for a YouTube URL' do
      _youtube_embed(youtube_url, 640, 390, 'http').should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0&rel=0" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"></iframe>}
    end
  end

  describe '::_vimeo_embed(url, 640, 390, http)' do
    it 'returns the embedding html for a Vimeo URL' do
      _vimeo_embed(vimeo_url, 640, 390, 'http').should == %Q{<iframe src="http://player.vimeo.com/video/49760839" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
    end
  end

  # describe '::_soundcloud_embed(url, http)' do
  #   it 'returns the embedding html for a SoundCloud URL' do
  #     _soundcloud_embed(soundcloud_url, 'http').should == %Q{<iframe width=\"100%\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F293&show_artwork=true\"></iframe>}
  #   end
  # end

  describe '::_wistia_embed(url, 640, 390, http)' do
    it 'returns the embedding html for a Wisita URL' do
      _wistia_embed(wistia_url, 640, 390, 'http').should == %Q{<iframe src="https://fast.wistia.net/embed/iframe/2cf8fbb2c0" title="Wistia video player" allowtransparency="true" frameborder="0" scrolling="no" class="wistia_embed" name="wistia_embed" allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width="640" height="390"></iframe>\n<script src="https://fast.wistia.net/assets/external/E-v1.js" async></script>}
    end
  end

  describe '::_facebook_embed(url, 640, 390, http)' do
    it 'returns the embedding html for a facebook' do
      _facebook_embed(facebook_url, 640, 390, 'http').should == %Q{<iframe src="http://www.facebook.com/plugins/video.php?href=http%3A%2F%2Fwww.facebook.com%2FFacebook360%2Fvideos%2F1681464425405359%2F&width=640" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
    end
  end

  describe '::embed(url)' do
    it 'embeds an YouTube video' do
      embed(youtube_url).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0&rel=0" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"></iframe>}
    end

    it 'embeds a Vimeo video' do
      embed(vimeo_url).should == %Q{<iframe src="http://player.vimeo.com/video/49760839" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
    end

    # FIXME: SoundCloud always return https (?)
    # it 'embeds a SoundCloud audio' do
    #   embed(soundcloud_url).should == %Q{<iframe width=\"100%\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F293&show_artwork=true\"></iframe>}
    # end

    it 'embeds a SoundCloud audio using https protocol' do
      embed(soundcloud_url, {:protocol => 'https'}).should == %Q{<iframe width=\"100%\" height=\"400\" scrolling=\"no\" frameborder=\"no\" src=\"https://w.soundcloud.com/player/?visual=true&url=https%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F293&show_artwork=true\"></iframe>}
    end
  end

  describe '::embed(url, 540, 290, https)' do
    it 'embeds an YouTube video with custom sizes and using https protocol' do
      embed(youtube_url, {:width => 540, :height => 290, :protocol => 'https'}).should == %Q{<iframe id="u1zgFlCw8Aw" type="text/html" width="540" height="290" src="https://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0&rel=0" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"></iframe>}
    end

    it 'embeds a Vimeo video with custom sizes and using https protocol' do
      embed(vimeo_url, {:width => 540, :height => 290, :protocol => 'https'}).should == %Q{<iframe src="https://player.vimeo.com/video/49760839" width="540" height="290" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
    end

    it 'embeds a Facebook video with custom sizes and using https' do
      embed(facebook_url, {:width => 540, :height => 290, :protocol => 'https'}).should == %Q{<iframe src="https://www.facebook.com/plugins/video.php?href=https%3A%2F%2Fwww.facebook.com%2FFacebook360%2Fvideos%2F1681464425405359%2F&width=540" width="540" height="290" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
    end

    #FIXME: Wistia always return videoHeight=360&videoWidth=640 ??
    #       Wistia not return https protocol
    # it 'embeds a Wistia video with custom sizes and using https protocol' do
    #   embed(wistia_url, {:width => 540, :height => 290, :protocol => 'https'}).should == %Q{<iframe src="https://fast.wistia.net/embed/iframe/2cf8fbb2c0" allowtransparency="true" frameborder="0" scrolling="no" class="wistia_embed" name="wistia_embed" width="540" height="290"></iframe>}
    # end

    it 'do nothing when no url' do
      embed(nil).should == nil
      embed("").should == nil
    end

  end
end
