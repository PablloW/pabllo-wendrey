class TweetsController < ApplicationController
  def index
    limit = params.fetch(:limit, 10).to_i
    cursor = params[:cursor].to_i

    tweets = Tweet.order(created_at: :desc)
    tweets = tweets.where('strftime("%s", created_at) < ?', cursor) if cursor.positive?
    tweets = tweets.limit(limit)

    render json: { tweets: tweets }
  end
end
