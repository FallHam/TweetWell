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
    tweets
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
    [lat,lon]
  end

  def tweets
    g = geocode
    @client.search("-rt", geocode: "#{g[0]},#{g[1]},100mi", lang: "en").take(200).map do |t|
      a = analyze(t.text)

      {
        weather: weather,
        sentiment: a["result"]["sentiment"],
        confidence: a["result"]["confidence"].to_f,
      }
     end
  end

  def analyze(text)
    HTTParty.post("http://sentiment.vivekn.com/api/text/", body: { txt: text } )
  end

  def sort(batch)
    positive_array = []
    negative_array = []
    neutral_array = []

    batch.each do |tweet|
      if tweet[:sentiment] == "Positive"
        positive_array << tweet
      elsif tweet[:sentiment] == "Negative"
        negative_array << tweet
      elsif tweet[:sentiment] == "Neutral"
        neutral_array << tweet
      else
        raise "error reading sentiments"
      end
    end
    @results = {}
    @results[:weather] = batch[0][:weather]
    @results[:positive] = average(positive_array)
    @results[:total_pos] = positive_array.length
    @results[:negative] = average(negative_array)
    @results[:total_neg] = negative_array.length
    @results[:neutral] = average(neutral_array)

    return @results
  end

  def average(arr)
    a = arr.reject{ |r| r[:confidence] < 65 }
    a.reduce(0.0) {|sum, r| sum + r[:confidence]} / a.length
  end

end
