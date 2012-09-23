# Embed

An easy way to embed media to your Rails app. Don't worry about messy embedding HTML anymore, just use the media URL.

As of now, it only supports YouTube and Vimeo.

## Installation

Add this line to your application's Gemfile:

    gem 'embed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install embed

## Usage

On your view:
```ruby
<%= embed("http://www.youtube.com/watch?v=fwncgZ15RVQ") %>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
