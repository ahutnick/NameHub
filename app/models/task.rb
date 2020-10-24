class Task < ApplicationRecord
  belongs_to :project

  STAGES = ['idea', 'ready', 'underway', 'review', 'completed'].freeze

  validates :title, presence: true
  validates :stage, presence: true, inclusion: { in: STAGES }

end
