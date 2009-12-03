class CreateExercises < ActiveRecord::Migration
  def self.up
    create_table :exercises do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :inactive_ind, :boolean
      t.column :course_id, :integer
      t.column :sort_order, :integer
    end
  end

  def self.down
    drop_table :exercises
  end
end
