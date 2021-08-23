class AddCapacityToPractices < ActiveRecord::Migration[6.0]
  def change
    add_column :practices, :capacity, :integer
  end
end
