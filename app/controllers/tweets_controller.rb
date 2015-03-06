class TweetsController < ApplicationController

  def index
    @tweets = Tweet.new.tweets(params[:q])
    render json: @tweets
  end
end
