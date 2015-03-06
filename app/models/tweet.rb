class Tweet < ActiveRecord::Base

  def initialize(search)
    @content = HTTParty.get(
    "https://api.twitter.com/1.1/search/tweets.json?q=#{search}",
    :headers => {"Authorization" => "token #{ENV['TWITTER_KEY']}",
    "User-Agent" => "anyone"})
  end

end
#
#

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
