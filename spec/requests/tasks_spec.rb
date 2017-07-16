# app/requests/tasks_spec.rb
require 'rails_helper'

RSpec.describe 'Tasks API' do
  # Initialize the test data
  let!(:board) { create(:board) }
  let!(:tasks) { create_list(:task, 20, board_id: board.id) }
  let(:board_id) { board.id }
  let(:id) { tasks.first.id }

  # Test suite for GET /boards/:board_id/tasks
  describe 'GET /boards/:board_id/tasks' do
    before { get "/boards/#{board_id}/tasks" }

    context 'when board exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all board tasks' do
        expect(json.size).to eq(20)
      end
    end

    context 'when board does not exist' do
      let(:board_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Board/)
      end
    end
  end

  # Test suite for GET /boards/:board_id/tasks/:id
  describe 'GET /boards/:board_id/tasks/:id' do
    before { get "/boards/#{board_id}/tasks/#{id}" }

    context 'when board task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the task' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when board task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for POST /boards/:board_id/tasks
  describe 'POST /boards/:board_id/tasks' do
    let(:valid_attributes) { { title: Faker::Lorem.word, description: Faker::Lorem.word, completed_at: nil } }

    context 'when request attributes are valid' do
      before { post "/boards/#{board_id}/tasks", valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for PUT /boards/:board_id/tasks/:id
  describe 'PUT /boards/:board_id/tasks/:id' do
    let(:valid_attributes) { { title: Faker::Lorem.word, description: Faker::Lorem.word } }

    before { put "/boards/#{board_id}/tasks/#{id}", valid_attributes }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the task' do
        updated_task = Task.find(id)
        expect(updated_task.title).to match(valid_attributes[:title])
        expect(updated_task.description).to match(valid_attributes[:description])
      end
    end

    context 'when the task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for PUT /boards/:board_id/tasks/:id
  describe 'PUT /boards/:board_id/tasks/:id' do

    before { put "/boards/#{board_id}/tasks/#{id}/complete" }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'completes the task' do
        completed_task = Task.find(id)
        expect(completed_task.completed_at.to_time).to be_kind_of(Time)
      end
    end

    context 'when the task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for DELETE /boards/:id
  describe 'DELETE /boards/:id' do
    before { delete "/boards/#{board_id}/tasks/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end