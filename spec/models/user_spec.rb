# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new }

  it { is_expected.to have_many(:notes) }
end
