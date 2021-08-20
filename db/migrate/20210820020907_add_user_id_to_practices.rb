class AddUserIdToPractices < ActiveRecord::Migration[6.0]
  def change
    add_column :practices, :user_id, :integer
  end
end
