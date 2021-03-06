class Comment < ApplicationRecord
  belongs_to :task

  validates :task_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
