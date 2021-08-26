class Practice < ApplicationRecord

  with_options presence: true do
    validates :name
    validates :price
    validates :practice_on
    validates :practice_at
    validates :place
    validates :comment
  end

  belongs_to :user
  has_one :practice_apply

end
