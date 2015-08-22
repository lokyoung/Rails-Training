class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_ADDRESS = /([\w+.]+)@[a-z0-9\-.]+\.[a-z]+/
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_ADDRESS },
                    uniqueness: true
  # has_secure_password方法要求对应模型中有名为password_digest的属性
  has_secure_password
end
