class CreateDeliverables < ActiveRecord::Migration
  def self.up
    create_table :deliverables do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :inactive_ind, :boolean
      t.column :exercise_id, :integer    
      t.column :type_id, :integer
      t.column :sort_order, :integer
    end
  end

  def self.down
    drop_table :deliverables
  end
end
