class PracticeApply < ApplicationRecord
  belongs_to :practice, dependent: :destroy
end
