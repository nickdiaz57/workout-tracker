class UsersController < ApplicationController

  get "/users/signup" do
    erb :"/users/signup"
  end

  post "/users/signup" do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect "/signup-failure"
    end
  end

  get "/users/login" do
    erb :"/users/login"
  end

  post "/users/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect "/login-failure"
    end
  end

  get "/signup-failure" do
    erb :"/users/signup-failure"
  end

  get "/login-failure" do
    erb :"/users/login-failure"
  end

  get "/users/:id" do
    login_check
    @user = current_user
    erb :"/users/home"
  end

  get "/users/:id/profile" do
    login_check
    @user = current_user
    erb :"/users/edit-profile"
  end
  
  patch "/users/:id" do
    login_check
    User.update(params[:id], first_name: params[:first_name], last_name: params[:last_name], username: params[:username])
    @user = User.find(params[:id])
    redirect "/users/#{@user.id}"
  end

  get "/logout" do
    logout
    redirect "/"
  end
end
