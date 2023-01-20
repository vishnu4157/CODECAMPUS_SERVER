class User < ApplicationRecord
    has_secure_password
    has_many :posts
    has_many :comments

    validates :name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
  end
  