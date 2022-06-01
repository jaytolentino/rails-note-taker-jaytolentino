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

  def create
    @note = Note.new(**note_params, user: current_user)

    if @note.save
      render json: @note, status: :ok
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  private

  def note_params
    params.permit(:title, :scheduled_at)
  end
end
