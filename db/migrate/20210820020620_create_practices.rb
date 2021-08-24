class CreatePractices < ActiveRecord::Migration[6.0]
  def change
    create_table :practices do |t|
      t.string     :name,        null: false
      t.integer    :price,       null: false
      t.references :user,        null: false, foreign_key: true
      t.date       :practice_on, null: false
      t.time       :practice_at, null: false
      t.text       :place,       null: false
      t.text       :comment,     null: false
      t.integer    :capacity
      
      t.timestamps
    end
  end
end
