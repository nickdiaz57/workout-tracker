class WorkoutsController < ApplicationController

  get "/users/:id/add-workout" do
    login_check
    @user = current_user
    erb :"/workouts/add-workout"  
  end

  post "/users/:id/workouts" do
    login_check
    user = current_user
    workout = Workout.new(params[:workout])
    if workout.save
      user.workouts << workout
      redirect "/users/#{user.id}"
    else
      redirect "/users/#{user.id}/add-workout"
    end
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
