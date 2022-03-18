class User < ApplicationRecord
  # validation
  validates :name,
            presence: true,
            length: { maximum: 40 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # relation
  has_many :lists, dependent: :destroy
end
