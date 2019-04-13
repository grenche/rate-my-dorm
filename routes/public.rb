class RateMyDorm < Sinatra::Base
  get '/' do
    erb :index
  end
end