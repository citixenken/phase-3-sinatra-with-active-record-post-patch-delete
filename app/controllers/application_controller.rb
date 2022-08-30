class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

  #delete req
  delete '/reviews/:id' do
    # find review using ID
    review = Review.find(params[:id])

    #delete review
    review.destroy

    #send response with delete review as response
    review.to_json
  end

  #post req
  post '/reviews' do
    # binding.pry
    review = Review.create(
      score: params[:score],
      comment: params[:comment],
      game_id: params[:game_id],
      user_id: paramså[:user_id]
    )
  review.to_json
  end

  #patch req
  patch '/reviews/:id' do
    review = Review.find(params[:id])
    review.update(
      score: params[:score],
      comment: params[:comment]
    )
    review.to_json

  end
end
