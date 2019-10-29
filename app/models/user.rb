class User < ApplicationRecord
  # validates :username, presence: true

  mount_uploader :photo, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings
  has_many :rentals, foreign_key: "customer_id", class_name: "Rental"

  has_many :reviews, through: :rentals
end
