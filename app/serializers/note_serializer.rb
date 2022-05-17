class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :scheduled_at, :user_id, :created_at, :updated_at

  def scheduled_at
    object.scheduled_at&.iso8601(3)
  end
end
