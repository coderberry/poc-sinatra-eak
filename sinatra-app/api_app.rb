require 'sinatra/base'

class ApiApp < Sinatra::Base

  set :protection, false # :except => :frame_options

  before do
    headers 'Access-Control-Allow-Origin' => '*', 
            'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']  
  end

  get '/rangers' do
    content_type :json
    [ 'Lone Ranger', 'Chuck Norris', 'Blue Ranger' ].to_json
  end

end