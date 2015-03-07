class TweetsController < ApplicationController

  def index

  end

  def show
    @tweets = Tweet.new.conditions(params[:state_code], params[:city])
    render json: @tweets
  end
end
