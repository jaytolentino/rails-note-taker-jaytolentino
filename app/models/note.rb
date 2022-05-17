# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 1..200 }

  scope :filter_by_title, ->(title) { where('title like ?', "%#{title}%") }

  def self.search(search)
    if search
      filter_by_title(search)
    else
      all
    end
  end
end
