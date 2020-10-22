class Task < ApplicationRecord
  belongs_to :project

  STAGES = ['idea', 'ready', 'in progress', 'review', 'completed'].freeze

  validates :title, presence: true
  validates :description, presence: true
  validates :stage, presence: true, inclusion: { in: STAGES }

end
