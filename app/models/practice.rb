class Practice < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :price
    validates :practice_on
    validates :practice_at
    validates :place
    validates :comment
  end

  belongs_to :user, optional: true
  has_many :practice_apply, foreign_key: 'practice_id', dependent: :destroy
end
