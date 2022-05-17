# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: (1..200)

  def to_resource
    {
      id: id,
      title: title,
      scheduled_at: scheduled_at ? scheduled_at.iso8601(3) : nil,
      created_at: created_at.iso8601(3),
      updated_at: updated_at.iso8601(3),
      user_id: user_id
    }
  end
end
