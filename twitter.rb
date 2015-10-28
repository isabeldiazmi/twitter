require "nokogiri"
require "open-uri"

class TwitterScrapper
  attr_accessor :doc
  
  def initialize(url)
    @doc = Nokogiri::HTML(File.open(url))
    @arr_stats = []
  end

  def interfaz
    puts "---------------------------------------------------"
    puts "Username: #{extract_username}"
    puts "---------------------------------------------------"
    puts "STATS -> Tweets: #{} Siguiendo: Seguidores: Favoritos:"
    puts "---------------------------------------------------"
    puts "Tweets:"
  end

  def extract_username
    profile_name = @doc.search(".ProfileHeaderCard-name > a")
    profile_name.first.inner_text
  end

  def extract_tweets
  end

  def extract_stats
    no_tweets = @doc.search(".ProfileNav-list > .ProfileNav-item:nth-child(1) > .ProfileNav-stat > span:nth-child(2)")
    @arr_stats << no_tweets.inner_text
    siguiendo = @doc.search(".ProfileNav-list > .ProfileNav-item:nth-child(2) > .ProfileNav-stat > span:nth-child(2)")
    @arr_stats << siguiendo.inner_text
    seguidores = @doc.search(".ProfileNav-list > .ProfileNav-item:nth-child(3) > .ProfileNav-stat > span:nth-child(2)")
    @arr_stats << seguidores.inner_text
    favoritos = @doc.search(".ProfileNav-list > .ProfileNav-item:nth-child(4) > .ProfileNav-stat > span:nth-child(2)")
    @arr_stats << favoritos.inner_text
    p @arr_stats
  end

end

twitter = TwitterScrapper.new('twitter_account.html')
#puts twitter.doc
#puts twitter.extract_username
twitter.interfaz
twitter.extract_stats