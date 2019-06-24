class User < ApplicationRecord
    validates :email,   presence: true,
                        format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i},
                        uniqueness: true
    validates :password, presence: true
    has_secure_password
end
