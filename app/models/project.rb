class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :comments, through: :tasks
  
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 250 }
end
