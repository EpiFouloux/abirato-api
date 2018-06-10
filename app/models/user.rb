# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :character_instances, dependent: :destroy, class_name: 'Character::Instance'

  validates :name, presence: true
  validates :email, presence: true
  validates :level, presence: true
  validates :experience_amount, presence: true
  validates :password_digest, presence: true

  validates_uniqueness_of :name, message: 'Has already been taken'
end
