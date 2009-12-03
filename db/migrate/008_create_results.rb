class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.column :student_id, :integer
      t.column :deliverable_id, :integer
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :results
  end
end
