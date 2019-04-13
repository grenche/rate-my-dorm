require 'rubygems'
require 'bundler'

require 'bcrypt'

Bundler.require

class RateMyDorm < Sinatra::Base
  @@last_login = Time.at(0)
  use Rack::Session::Cookie, :key => 'rack.session',
      :expire_after               => 2592000,
      :secret                     => SecureRandom.hex(64)
  use Rack::Protection
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end
end

Dir['./models/*.rb'].each { |file| require file }

# User.each {|user| user.generate_token}

Dir['./helpers/*.rb'].each { |file| require file }
Dir['./routes/*.rb'].each { |file| require file }

run RateMyDorm
