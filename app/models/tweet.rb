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
    @client.search(" ", geocode: "#{g[0]},#{g[1]},100mi", lang: "en").take(10).map do |t|
      a = analyze(t.text)
       {
         name: t.user.screen_name,
         text: t.text,
         sentiment: a["result"]["sentiment"],
         confidence: a["result"]["confidence"]
       }

     end
  end

  def analyze(text)
    HTTParty.post("http://sentiment.vivekn.com/api/text/", body: { txt: text } )
  end

  def sort(batch)

    postitive_array = []
    negative_array = []
    neutral_array = []

    batch.each do |tweet|
      if tweet[:sentiment] == "Positive"
        postitive_array << tweet
      elsif tweet[:sentiment] == "Negative"
        negative_array << tweet
      elsif tweet[:sentiment] == "Neutral"
        neutral_array << tweet
      else
        raise "error reading sentiments"
      end
    end
    results = {}
    results[:positive] = postitive_array
    results[:negative] = negative_array
    results[:neutral] = neutral_array
    return results
  end





  #
  # def positive
  #   positive_array = []
  #   positive_array << @sample.select {"sentiment" == "positive"}
  # end
  #
  # def negative
  #   negative_array = @sample.select {"sentiment" == "negative"}
  # end
  #
  # def nuetral
  #   @sample.select {"sentiment" == "nuetral"}
  # end
  #
  # def average(array)
  #   count = Array.length
  #   @array.each do |a|
  #     (confidence.sum) / count
  #   end
  #   return count
  #
  # end
  #
  # average(positive)
  #


end
