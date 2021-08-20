class CreatePracticeApplies < ActiveRecord::Migration[6.0]
  def change
    create_table :practice_applies do |t|
      t.references :practice, foreign_key: true

      t.timestamps
    end
  end
end
