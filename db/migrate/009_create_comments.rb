class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :student_id, :integer
      t.column :exercise_id, :integer
      t.column :tech_grade_id, :integer
      t.column :comments, :text
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :comments
  end
end
