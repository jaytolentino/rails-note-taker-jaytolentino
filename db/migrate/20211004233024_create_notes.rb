# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.datetime :scheduled_at

      t.timestamps
    end
  end
end
