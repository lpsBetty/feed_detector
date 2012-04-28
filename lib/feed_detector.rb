require "feed_detector/version"
require "net/http"
require "uri"
require "nokogiri"

module FeedDetector
  
  # returns all feed urls from one url
  # for example: http://blog.dominiek.com/ => http://blog.dominiek.com/feed/atom.xml
  # only_detect can force detection of :rss or :atom
  # if nil is returned no feeds were detected - perhaps because it's the feed url
  def self.fetch_feed_urls(page_url, only_detect=nil)
    retries = 3 # default retries
    html = ""
    begin
      response = Net::HTTP.get_response(URI.parse(page_url)) # sends get request
      html = response.body
    rescue
      retries -= 1
      if retries > 0
        sleep 0.42 and retry
      else
        raise
      end
    end

    feed_urls = self.get_feed_paths(html, only_detect)
    feed_urls.map { |feed_url| self.to_absolute_url(page_url, feed_url) }
  end

  # get the feed href from an HTML document
  # for example:
  # ...
  # <link href="/feed/atom.xml" rel="alternate" type="application/atom+xml" />
  # => /feed/atom.xml
  # only_detect can force detection of :rss or :atom
  def self.get_feed_paths(html, only_detect=nil)
    matches = []

    # parse html with nokogiri to find all link tags (see self.get_link_href)
    doc = Nokogiri::HTML.parse(html)

    unless only_detect
      ["rss", "atom"].each do |type|
        matches << get_link_href(doc, type)
      end
    else
      matches << get_link_href(doc, only_detect.to_s)
    end

    matches.flatten
  end

  private

  # finding all link tags and get the attribute href
  # types: rss or atom
  def self.get_link_href doc, type
    doc.css('link[type="application/'+type+'+xml"]').map { |link| link['href'] }
  end

  # converts relative urls to absolute urls
  def self.to_absolute_url(page_url,feed_url)
    return feed_url if feed_url =~ /^http:\/\// # already absolute

    if feed_url =~ /^\//  # relative to the host root ## '/some_dir_from_root/feed.xml'
      "http://#{URI.parse(page_url).host.to_s + feed_url}"
    else  # relative to the page path ## 'feed.xml'
      feed_path = page_url.scan(/^(http:\/\/[^\/]+)((?:\/[^\/]+)+(?=\/))?\/?(?:[^\/]+)?$/i).to_s
      feed_path +'/'+ feed_url
    end
  end


end
