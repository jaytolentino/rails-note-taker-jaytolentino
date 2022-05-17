# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes API', type: :request, subdomain: 'app' do
  def expected_note_json(note = {})
    {
      'id' => note.id,
      'title' => note.title,
      'scheduled_at' => note.scheduled_at.iso8601(3),
      'created_at' => note.created_at.iso8601(3),
      'updated_at' => note.updated_at.iso8601(3),
      'user_id' => note.user.id
    }
  end
  let!(:user) { User.new(email: 'test@test.com', password: 'password') }
  let!(:note) do
    Note.create(
      title: "I'm a note!",
      scheduled_at: 1.day.from_now,
      user: user
    )
  end
  let!(:note2) do
    Note.create(
      title: 'Also a NOTE!',
      scheduled_at: 1.day.from_now,
      user: user
    )
  end

  before { login_as(user) }

  shared_examples_for 'unauthenticated user' do
    before { logout }

    it 'returns a redirect' do
      expect(subject).to redirect_to '/users/sign_in'
    end
  end

  shared_examples_for 'bad params' do
    context 'bad params' do
      let(:params) do
        {
          title: nil,
          scheduled_at: 1.day.from_now
        }
      end

      it 'returns a 422' do
        subject
        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET /notes' do
    let(:query) { nil }
    subject { get "/notes#{query}" }

    it 'returns a 200' do
      subject
      expect(response.status).to eq 200
    end

    it 'renders json notes' do
      subject
      expect(json_response).to be_an Array
      expect(json_response.length).to eq 2
      expect(json_response[0]).to eq expected_note_json(note)
      expect(json_response[1]).to eq expected_note_json(note2)
    end

    context 'with a query' do
      let(:query) { '?query=also a note' }

      it 'filters' do
        subject
        expect(json_response).to be_an Array
        expect(json_response.length).to eq 1
        expect(json_response[0]).to eq expected_note_json(note2)
      end
    end

    it_behaves_like 'unauthenticated user'
  end

  describe 'GET /notes/:id' do
    subject { get "/notes/#{note.id}" }

    it 'returns a 200' do
      subject
      expect(response.status).to eq 200
    end

    it 'renders renders the note' do
      subject
      expect(json_response).to eq expected_note_json(note)
    end

    it_behaves_like 'unauthenticated user'
  end

  describe 'POST /notes' do
    let(:params) do
      {
        title: 'My new note',
        scheduled_at: 1.day.from_now
      }
    end

    subject { post '/notes', params: params }

    it 'returns a 200' do
      subject
      expect(response.status).to eq 200
    end

    it 'creates a note' do
      expect { subject }.to change { user.notes.count }.by 1
    end

    it 'renders the new note' do
      subject
      expect(json_response).to eq expected_note_json(user.notes.last)
    end

    it_behaves_like 'bad params'
    it_behaves_like 'unauthenticated user'
  end

  describe 'PUT /note/:id' do
    let(:params) do
      {
        title: 'Updated note title',
        scheduled_at: 1.day.from_now
      }
    end

    subject { put "/notes/#{note.id}", params: params }

    it 'returns a 200' do
      subject
      expect(response.status).to eq 200
    end

    it 'renders the note' do
      subject
      expect(json_response).to eq expected_note_json(note.reload)
    end

    it 'updates the note' do
      expect { subject }.to change { note.reload.title }.to(params[:title])
    end

    it_behaves_like 'bad params'
    it_behaves_like 'unauthenticated user'
  end

  describe 'DELETE /note/:id' do
    subject { delete "/notes/#{note.id}" }

    it 'returns a 204' do
      subject
      expect(response.status).to eq 204
    end

    it 'returns an empty body' do
      subject
      expect(response.body).to eq ''
    end

    it 'deletes the note' do
      expect { subject }.to change { Note.find_by(id: note.id) }.to nil
    end

    it_behaves_like 'unauthenticated user'
  end
end
