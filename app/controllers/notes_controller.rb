# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:destroy, :update]

  def index
    @notes = Note.search(notes_params[:query])

    render json: @notes
  end

  def show
    render json: @note
  end

  def create
    @note = current_user.notes.build(notes_params)

    if @note.save
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
  end

  def update
    if @note.update(notes_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  private

  def set_note
    @note = Note.find(notes_params[:id])
  end

  def notes_params
    params.permit(:id, :title, :scheduled_at, :user_id, :query)
  end
end
