require "spec_helper"

describe Embed do
  describe "::youtube_video_id(url)" do
    {
      "full URL" => ["https://www.youtube.com/watch?v=dMH0bHeiRNg", "dMH0bHeiRNg"],
      "short URL" => ["https://youtu.be/dMH0bHeiRNg", "dMH0bHeiRNg"],
      "YT Shorts URL" => ["https://www.youtube.com/shorts/KZvrP8Mfsyo", "KZvrP8Mfsyo"],
      "URL ending with v/" => ["https://youtu.be/KZvrP8Mfsyv/", "KZvrP8Mfsyv"]
    }.each do |description, (url, id)|
      it "returns the YouTube video id from a #{description}" do
        expect(Embed.youtube_video_id(url)).to eq(id)
      end
    end
  end

  describe "::vimeo_video_id(url)" do
    it "returns the Vimeo video id from its URL" do
      expect(Embed.vimeo_video_id("https://vimeo.com/49760839")).to eq("49760839")
    end
  end
end
