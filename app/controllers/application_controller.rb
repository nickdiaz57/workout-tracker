require './config/environment'

class ApplicationController < Sinatra::Base

  ENV["SESSION_SECRET"] = 'SESSION_SECRET'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get "/" do
    erb :welcome
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def logout
      session.clear
    end
    
    def login_check
      redirect "/" if !logged_in?
    end

  end

end
