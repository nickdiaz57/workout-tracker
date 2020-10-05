class WorkoutsController < ApplicationController

  get "/users/:id/add-workout" do
    login_check
    @user = current_user
    erb :"/workouts/add-workout"
  end

  post "/users/:id/workouts" do #add error handling for bad workout creation
    login_check
    user = current_user
    workout = Workout.new(params[:workout])
    user.workouts << workout
    workout.save
    redirect "/users/#{user.id}"
  end

  get "/users/:id/edit-workout" do
    login_check
    @user = current_user
    erb :"/workouts/edit-workout"
  end

  patch "/users/workouts/:id" do
    login_check
    Workout.update(params[:id], name: params[:name], content: params[:content], score: params[:score])
    @user = current_user
    redirect "/users/#{@user.id}"
  end
  
  delete "/users/workouts/:id" do
    login_check
    Workout.delete(params[:id])
    @user = current_user
    redirect "users/#{@user.id}"
  end
end
