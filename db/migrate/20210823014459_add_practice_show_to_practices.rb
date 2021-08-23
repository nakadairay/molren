class AddPracticeShowToPractices < ActiveRecord::Migration[6.0]
  def change
    add_column :practices, :practice_on, :date
    add_column :practices, :practice_at, :datetime
    add_column :practices, :place, :text
    add_column :practices, :comment, :text
  end
end
