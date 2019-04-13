class Array # hack so that partial works
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
end

class RateMyDorm < Sinatra::Base
  helpers do
    include Rack::Utils
    alias_method :h, :escape_html

    def development?
      ENV['RACK_ENV'] == 'development'
    end

    # Convert a hash to a querystring for form population   # is used
    def hash_to_query_string(hash)
      hash.delete 'password'
      hash.delete 'password_confirmation'
      hash.collect { |k, v| "#{k}=#{v}" }.join('&')
    end

    def partial(template, *args)
      options = args.extract_options!
      options.merge!(:layout => false)
      if collection = options.delete(:collection) then #I know that the "then" here is bad style, but I didn't write this!
        collection.inject([]) do |buffer, member|
          buffer << erb(template, options.merge(
              :layout => false,
              :locals => {template.to_sym => member}
          )
          )
        end.join("\n")
      else
        erb(template, options)
      end
    end

    def rate_limit
      halt 429, "Rate limiting engaged. Please try again in 30 seconds" if Time.now - @@last_login < 10
    end
  end
end
