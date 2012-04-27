# FeedDetector

Detecting RSS feeds: When you use a proper browser like Mozilla Firefox you will see a syndication icon every time you visit a website that has RSS feeds:

It does this by reading certain HTML tags.

After a quick search I couldn’t find any code to do this in my own project, so I wrote a little piece of code for it with a RubyOnRails integration test.

## Installation

Add this line to your application's Gemfile:

    gem 'feed_detector'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feed_detector

## Usage

    FeedDetector.fetch_feed_urls('http://www.rubycorner.com')
    => ["http://www.rubycorner.com/feeds/updated/atom10", "http://www.rubycorner.com/feeds/updated/rss20"]

    FeedDetector.fetch_feed_urls('http://blog.dominiek.com/')
     => ["http://blog.dominiek.com/feed/atom.xml"]

    FeedDetector.fetch_feed_urls('http://blog.dominiek.com/feed/atom.xml')
    => ["http://blog.dominiek.com/feed/atom.xml"]

    FeedDetector.fetch_feed_urls('http://www.flickr.com/photos/dominiekterheide/', :rss)
    => ["http://api.flickr.com/services/feeds/photos_public.gne?id=71386598@N00&amp;lang=en-us&format=rss_200"]

alternatively you can parse HTML with 
    
    FeedDetector.get_feed_paths(html_data)

see integration test for more examples

## TODO
* Decouple parsing and retrieving data.
* Tests should not depend on data retrieved from the web taking a particular form.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
