require "nokogiri"
require "open-uri"

class TwitterScrapper
  attr_accessor :doc
  
  def initialize(url)
    @doc = Nokogiri::HTML(File.open(url))
  end

  def interfaz
    puts "Username: #{extract_username}"
    puts "---------------------------------------------------"
    puts "STATS -> Tweets: Siguiendo: Seguidores: Favoritos:"
    puts "---------------------------------------------------"
    puts "Tweets:"
  end

  def extract_username
    profile_name = doc.search(".ProfileHeaderCard-name > a")
    profile_name.first.inner_text
  end

  def extract_tweets
  end

  def extract_stats
  end

end

twitter = TwitterScrapper.new('twitter_account.html')
#puts twitter.doc
puts twitter.extract_username