class User < ApplicationRecord
    has_many :projects, dependent: :destroy
    has_many :tasks, through: :projects
    has_many :comments, through: :tasks
    has_many :activities

    has_secure_password
    
    attr_accessor :remember_token

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :name,  presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    before_validation { self.email.downcase! }  
  
    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                            BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
    
        
        def new_token
            SecureRandom.urlsafe_base64
        end
    end
  
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end
  end
