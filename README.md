# Embed

An easy way to embed media to your Rails app. Don't worry about messy embedding HTML anymore, just use the media URL.

As of now it supports YouTube, Vimeo, Wistia and SoundCloud.

## Installation

Add this line to your application's Gemfile:

    gem 'embed'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install embed

## Usage

On your view

```ruby
<%= embed("https://www.youtube.com/watch?v=fwncgZ15RVQ") %>
```

```ruby
<%= embed('https://www.youtube.com/watch?v=fwncgZ15RVQ', {:width => 540, :height => 290}) %>
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
