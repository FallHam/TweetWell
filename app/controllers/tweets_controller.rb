class TweetsController < ApplicationController

  def index

  end

  def show
    batch = Tweet.new.conditions(params[:state_code], params[:city])
    response = Tweet.new.sort(batch)
    render json: response
  end
end
