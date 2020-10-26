class Task < ApplicationRecord
  has_many :comments, dependent: :destroy
  
  belongs_to :project

  STAGES = ['idea', 'ready', 'underway', 'review', 'completed'].freeze

  validates :title, presence: true
  validates :stage, presence: true, inclusion: { in: STAGES }

end
