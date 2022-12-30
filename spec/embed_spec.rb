require "spec_helper"

describe Embed do
  describe "::youtube_video_id(url)" do
    it "returns the YouTube video id from a full URL" do
      url = "https://www.youtube.com/watch?v=dMH0bHeiRNg"
      Embed.youtube_video_id(url).should == "dMH0bHeiRNg"
    end

    it "returns the YouTube video id from a short URL" do
      url = "https://youtu.be/dMH0bHeiRNg"
      Embed.youtube_video_id(url).should == "dMH0bHeiRNg"
    end

    it "returns the YouTube video id from a YT Shorts URL" do
      url = "https://www.youtube.com/shorts/KZvrP8Mfsyo"
      Embed.youtube_video_id(url).should == "KZvrP8Mfsyo"
    end

    it "works with a URL ending with v/" do
      url = "https://youtu.be/KZvrP8Mfsyv/"
      Embed.youtube_video_id(url).should == "KZvrP8Mfsyv"
    end
  end

  describe "::vimeo_video_id(url)" do
    it "returns the Vimeo video id from its URL" do
      url = "https://vimeo.com/49760839"
      Embed.vimeo_video_id(url).should == "49760839"
    end
  end
end
