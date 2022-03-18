class Card < ApplicationRecord
  # relation
  belongs_to :list

  # validation
  validates :title, :memo,
            presence: true
  validates :title,
            length: { maximum: 30 }
  validates :memo,
            length: { maximum: 100 }
end
