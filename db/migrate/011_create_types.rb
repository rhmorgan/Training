class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :score_ind, :boolean
      t.column :sort_order, :integer
    end
  end

  def self.down
    drop_table :types
  end
end
