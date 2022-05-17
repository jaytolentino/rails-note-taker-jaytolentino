# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    notes = current_user.notes.order(created_at: :asc)
    notes = notes.where('lower(title) LIKE ?', "%#{params[:query].downcase}%") if params[:query]

    render json: notes.map(&:to_resource)
  end

  def show
    note = Note.find(params[:id])
    render json: note.to_resource
  end

  def create
    note = current_user.notes.build(permitted_params)

    if note.save
      render json: note.to_resource
    else
      head :unprocessable_entity
    end
  end

  def update
    note = Note.find(params[:id])

    if note.update(permitted_params)
      render json: note.to_resource
    else
      head :unprocessable_entity
    end
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    head :no_content
  end

  private

  def permitted_params
    params.permit(:title, :scheduled_at)
  end
end
