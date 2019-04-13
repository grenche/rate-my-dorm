class RateMyDorm < Sinatra::Base
  get '/' do
    erb :blank
  end

  get '/reviews.erb' do
    erb :reviews
  end

  get '/rate-room.erb' do
    erb :make_review
  end

  get '/find-room.erb' do
    erb :blank
  end
end