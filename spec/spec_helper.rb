require "rspec/expectations"
require "embed"
require "embed_helper"

RSpec.configure do |rspec|
  rspec.expect_with :rspec do |c|
    c.max_formatted_output_length = nil
  end
end
