# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  subject { Note.new(user: User.new(email: 'test@test.com', password: 'password')) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_least(1).is_at_most(200) }
  it { is_expected.to belong_to(:user) }
end
