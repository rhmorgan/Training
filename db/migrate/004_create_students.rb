class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.column :name, :string
      t.column :section_id, :integer
      t.column :inactive_Ind, :boolean
    end
  end

  def self.down
    drop_table :students
  end
end
