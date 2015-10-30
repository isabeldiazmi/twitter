require "nokogiri"
require "open-uri"

class TwitterScrapper
  attr_accessor :doc
  attr_reader :arr_fechas, :arr_tweets
  
  def initialize(url)
    @doc = Nokogiri::HTML(File.open(url))
    @arr_stats = []
    @arr_tweets = []
    @arr_fechas = []
  end

  def extract_username
    profile_name = @doc.search(".ProfileHeaderCard-name > a")
    profile_name.first.inner_text
  end

  def extract_tweets(num)
    (num+1).times do |n|
      @arr_fechas <<  @doc.search(".stream-container > .stream > .stream-items > .js-stream-item:nth-child(#{n}) > .tweet > .content > .stream-item-header > .time > .tweet-timestamp > span").inner_text
      @arr_tweets <<  @doc.search(".stream-container > .stream > .stream-items > .js-stream-item:nth-child(#{n}) > .tweet > .content > p").inner_text
    end
    @arr_tweets.delete_at(0)
    @arr_fechas.delete_at(0)
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
    @arr_stats
  end
end

def interfaz(url, num)
  twitter = TwitterScrapper.new(url)
  puts "-------------------------------------------------------------------------"
  puts "Username: #{twitter.extract_username}"
  puts "-------------------------------------------------------------------------"
  puts "STATS -> Tweets: #{twitter.extract_stats[0]} Siguiendo: #{twitter.extract_stats[1]} Seguidores: #{twitter.extract_stats[2]} Favoritos: #{twitter.extract_stats[3]}"
  puts "-------------------------------------------------------------------------"
  puts "Tweets:"
  twitter.extract_tweets(num)
  num.times do |i|
    puts "#{twitter.arr_fechas[i]}: #{twitter.arr_tweets[i]}"
  end
end

address = "https://twitter.com/" + ARGV[0] #acordarme que tienes que darle un arreglo desde la consola
html_file = open(address)
interfaz(html_file, 5)