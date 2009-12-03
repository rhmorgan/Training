class CreateSetups < ActiveRecord::Migration
  def self.up
    create_table :setups do |t|
      t.column :course_id, :integer
      t.column :section_id, :integer
    end
  end

  def self.down
    drop_table :setups
  end
end
