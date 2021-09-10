class AddAppliesCountToPractices < ActiveRecord::Migration[6.0]
  def self.up
    add_column :practices, :applies_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :practices, :applies_count
  end
end
