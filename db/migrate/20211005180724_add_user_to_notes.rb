# frozen_string_literal: true

class AddUserToNotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :notes, :user
  end
end
