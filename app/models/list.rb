class List < ApplicationRecord
  # relation
  belongs_to :user
  has_many :cards, dependent: :destroy

  # validation
  validates :title,
            presence: true,
            length: { maximum: 50 }
end
