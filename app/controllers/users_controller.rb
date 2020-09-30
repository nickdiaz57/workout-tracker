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
    @user = User.find(session[:user_id])
    erb :"/users/home"
  end

  get "/users/:id/add-workout" do
    @user = User.find(session[:user_id])
    erb :"/users/add-workout"
  end

  post "/users/workouts" do
    user = User.find(session[:user_id])
    workout = Workout.new(params[:workout])
    user.workouts << workout
    workout.save
    redirect "/users/#{user.id}"
  end

#   ################
#   ################




#   # GET: /users
#   get "/users" do
#     erb :"/users/index.html"
#   end

#   # GET: /users/new
#   get "/users/new" do
#     erb :"/users/new.html"
#   end

#   # POST: /users
#   post "/users" do
#     redirect "/users"
#   end

#   # GET: /users/5
#   get "/users/:id" do
#     erb :"/users/show.html"
#   end

#   # GET: /users/5/edit
#   get "/users/:id/edit" do
#     erb :"/users/edit.html"
#   end

#   # PATCH: /users/5
#   patch "/users/:id" do
#     redirect "/users/:id"
#   end

#   # DELETE: /users/5/delete
#   delete "/users/:id/delete" do
#     redirect "/users"
#   end
end
