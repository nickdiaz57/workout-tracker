class AddContentToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :content, :string
  end
end
