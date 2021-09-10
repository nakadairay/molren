class PracticeApply < ApplicationRecord
  belongs_to :practice, dependent: :destroy
  counter_culture :practice, column_name: 'applies_count'
  
  belongs_to :user
end
