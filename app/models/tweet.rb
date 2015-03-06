class Tweet

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token= ENV['ACCESS_TOKEN']
      config.access_token_secret= ENV['ACCESS_TOKEN_SECRET']
    end
  end

  def tweets(search)
    @client.search("#{search} -rt", lang: "en").take(10)
      .map{|t| [t.user.screen_name, t.text, analyze(t.text)]}
  end

  def analyze(text)
    HTTParty.post("http://sentiment.vivekn.com/api/text/", body: { txt: text } )
  end
end
