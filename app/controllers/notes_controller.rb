# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    query = params[:query]

    @notes = if query.present?
      Note.where('title LIKE ?', "%#{query}%").all
    else
      Note.all
    end

    render json: @notes
  end
end
