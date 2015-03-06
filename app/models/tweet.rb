class Tweet

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token= ENV['ACCESS_TOKEN']
      config.access_token_secret= ENV['ACCESS_TOKEN_SECRET']
    end
  end

  def conditions(state_code, city)
    @weather = HTTParty.get("http://api.wunderground.com/api/#{ENV['WUNG_KEY']}/conditions/q/#{state_code}/#{city}.json")
  end

  def weather
    @weather["current_observation"]["weather"]
  end

  def temp
    @weather["current_observation"]["temperature_string"]
  end

  def humidity
    @weather["current_observation"]["relative_humidity"]
  end

  def geocode
    lat = @weather["current_observation"]["display_location"]["latitude"]
    lon = @weather["current_observation"]["display_location"]["longitude"]
    @geocode = [lat,lon].to_s
  end

  def tweets
    @client.search("", geocode: "#{@geocode},100mi", lang: "en").take(100).collect
  end

  def analyze(text)
    HTTParty.post("http://sentiment.vivekn.com/api/text/", body: { txt: text } )
  end




end
# .map{|t| t}

  # [t.user.screen_name, t.text, analyze(t.text)]}


  "weather": "Partly Cloudy",
  "temperature_string": "66.3 F (19.1 C)",

  "relative_humidity": "65%",
