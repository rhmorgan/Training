class CreateExercisesUsers < ActiveRecord::Migration
  def self.up
    create_table :exercises_users, :id => false do |t|
      t.column :exercise_id, :integer
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :exercises_users
  end
end
