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
    @client.search("##{search} -rt", lang: "en").take(10)
      .map{|t| [t.user.screen_name, t.text, analyze(t.text)]}
  end

  def analyze(text)
    HTTParty.post("http://sentiment.vivekn.com/api/text/", body: { txt: text } )
  end
end



#   def initialize(search)
#     @content = HTTParty.get(
#     "https://api.twitter.com/1.1/search/tweets.json?q=#{search}",
#     :headers => {"Authorization" => "token #{ENV['TWITTER_KEY']}",
#     "User-Agent" => "anyone"
#   }
#   )
# end
# class ProfileController < ApplicationController
#   def show
#     profile_url = "https://api.github.com/users/Fallonious/repos"
#     @profile = HTTParty.get(profile_url, login_info)
#
#     avatar_url = "https://api.github.com/users/Fallonious"
#     @avatar = HTTParty.get(avatar_url, login_info) ["avatar_url"]
#   end
#
#   private def login_info
#     {:headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
#     "User-Agent" => "User-Agent"}
#   }
# end
# end
