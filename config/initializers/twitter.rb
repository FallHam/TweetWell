@client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.access_token= ENV['ACCESS_TOKEN']
  config.access_token_secret= ENV['ACCESS_TOKEN_SECRET']
end

# client.search("to:justinbieber marry me", result_type: "recent").take(5).collect do |tweet|
#   "#{tweet.user.screen_name}: #{tweet.text}"
# end
#
# client.search("durham", result_type: "recent").take(5).collect do |tweet|
#   "#{tweet.text}"
# end
