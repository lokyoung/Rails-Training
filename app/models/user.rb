class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_ADDRESS = /([\w+.]+)@[a-z0-9\-.]+\.[a-z]+/
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_ADDRESS },
                    uniqueness: true
  # has_secure_password方法要求对应模型中有名为password_digest的属性
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 返回一个随机令牌
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
