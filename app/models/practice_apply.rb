class PracticeApply < ApplicationRecord
  belongs_to :practice, dependent: :destroy
  belongs_to :user
end
