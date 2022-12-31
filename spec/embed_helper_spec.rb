require "spec_helper"

describe Embed::EmbedHelper do
  let(:subject) {
    Class.new do
      include Embed::EmbedHelper
    end.new
  }
  let(:youtube_url) { "https://www.youtube.com/watch?v=u1zgFlCw8Aw" }
  let(:vimeo_url) { "https://vimeo.com/49760839" }
  let(:soundcloud_url) { "https://soundcloud.com/forss/flickermood" }
  let(:wistia_url) { "https://fast.wistia.com/embed/iframe/2cf8fbb2c0" }
  let(:facebook_url) { "https://www.facebook.com/Facebook360/videos/1681464425405359/" }

  describe "::_youtube_embed(url, 640, 390)" do
    it "returns the embedding html for a YouTube URL" do
      expect(subject._youtube_embed(youtube_url, 640, 390)).to eq(%(<iframe id="youtube-u1zgFlCw8Aw" src="https://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0&rel=0" type="text/html" width="640" height="390" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"></iframe>))
    end
  end

  describe "::_vimeo_embed(url, 640, 390)" do
    it "returns the embedding html for a Vimeo URL" do
      expect(subject._vimeo_embed(vimeo_url, 640, 390)).to eq(%(<iframe id=\"vimeo-49760839\" src="https://player.vimeo.com/video/49760839" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>))
    end
  end

  describe "::_soundcloud_embed(url)" do
    it "returns the embedding html for a SoundCloud URL" do
      expect(subject._soundcloud_embed(soundcloud_url)).to eq(%(<iframe width="100%" height="400" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?visual=true&url=https%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F293&show_artwork=true"></iframe>))
    end
  end

  describe "::_wistia_embed(url, 640, 390)" do
    it "returns the embedding html for a Wisita URL" do
      expect(subject._wistia_embed(wistia_url, 640, 390)).to eq(%(<iframe src="https://fast.wistia.net/embed/iframe/2cf8fbb2c0" title="Final Launch Video " allow="autoplay; fullscreen" allowtransparency="true" frameborder="0" scrolling="no" class="wistia_embed" name="wistia_embed" msallowfullscreen width="640" height="390"></iframe>\n<script src="https://fast.wistia.net/assets/external/E-v1.js" async></script>))
    end
  end

  describe "::_facebook_embed(url, 640, 390)" do
    it "returns the embedding html for a facebook" do
      expect(subject._facebook_embed(facebook_url, 640, 390)).to eq(%(<iframe id="facebook-c097b5fbd0087379ded7aa83847d91a120608e0a" src="https://www.facebook.com/plugins/video.php?href=https%3A%2F%2Fwww.facebook.com%2FFacebook360%2Fvideos%2F1681464425405359%2F&width=640&show_text=0" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>))
    end
  end

  describe "::embed(url)" do
    it "embeds an YouTube video" do
      expect(subject.embed(youtube_url)).to eq(%(<iframe id="youtube-u1zgFlCw8Aw" src="https://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0&rel=0" type="text/html" width="640" height="390" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"></iframe>))
    end

    it "embeds a Vimeo video" do
      expect(subject.embed(vimeo_url)).to eq(%(<iframe id=\"vimeo-49760839\" src="https://player.vimeo.com/video/49760839" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>))
    end

    it "embeds a SoundCloud audio" do
      expect(subject.embed(soundcloud_url)).to eq(%(<iframe width="100%" height="400" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?visual=true&url=https%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F293&show_artwork=true"></iframe>))
    end
  end

  describe "::embed(url, 'http')" do
    it "warns about the deprecation of the protocol option" do
      begin
        original_stderr = $stderr
        $stderr = Class.new do
          attr_accessor :messages

          def initialize
            @messages = []
          end

          def write(message)
            messages << message
          end
        end.new

        subject.embed(youtube_url, {protocol: "http"})
        expect($stderr.messages.first).to match(/Embed\.video_url\(url, protocol\) is deprecated/)
      ensure
        $stderr = original_stderr
      end
    end

    it "embeds an YouTube video" do
      expect(subject.embed(youtube_url, {protocol: "http"})).to eq(%(<iframe id="youtube-u1zgFlCw8Aw" src="http://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0&rel=0" type="text/html" width="640" height="390" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"></iframe>))
    end

    it "embeds a Vimeo video" do
      expect(subject.embed(vimeo_url, {protocol: "http"})).to eq(%(<iframe id=\"vimeo-49760839\" src="http://player.vimeo.com/video/49760839" width="640" height="390" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>))
    end
  end

  describe "::embed(url, {width: 540, height: 290})" do
    it "embeds an YouTube video with custom sizes" do
      expect(subject.embed(youtube_url, {width: 540, height: 290})).to eq(%(<iframe id="youtube-u1zgFlCw8Aw" src="https://www.youtube.com/embed/u1zgFlCw8Aw?autoplay=0&rel=0" type="text/html" width="540" height="290" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"></iframe>))
    end

    it "embeds a Vimeo video with custom sizes" do
      expect(subject.embed(vimeo_url, {width: 540, height: 290})).to eq(%(<iframe id=\"vimeo-49760839\" src="https://player.vimeo.com/video/49760839" width="540" height="290" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>))
    end

    it "embeds a Facebook video with custom size" do
      expect(subject.embed(facebook_url, {width: 540, height: 290})).to eq(%(<iframe id="facebook-c097b5fbd0087379ded7aa83847d91a120608e0a" src="https://www.facebook.com/plugins/video.php?href=https%3A%2F%2Fwww.facebook.com%2FFacebook360%2Fvideos%2F1681464425405359%2F&width=540&show_text=0" width="540" height="290" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>))
    end

    it "do nothing when no url" do
      expect(subject.embed(nil)).to be_nil
      expect(subject.embed("")).to be_nil
    end
  end
end
