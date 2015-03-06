class TweetsController < ApplicationController

  def index

  end

  def show
    @tweets = Tweet.new.tweets(params[:search])
    render json: @tweets
  end
end
