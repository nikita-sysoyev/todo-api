# app/requests/dashboard_spec.rb
require 'rails_helper'

RSpec.describe 'Dashboard API' do
  # Initialize the test data
  let!(:boards) { create_list(:board, 10) }
  let!(:complete_tasks) { create_list(:task, 10, board_id: boards[rand(10)].id, completed_at: Time.now) }
  let!(:incomplete_tasks) { create_list(:task, 10, board_id: boards[rand(10)].id) }

  # Test suite for GET /
  describe 'GET /' do
    before { get "/" }

  	context 'when board task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the task' do
        expect(json['total_boards']).to eq(boards.count)
        expect(json['total_tasks']).to eq(complete_tasks.count + incomplete_tasks.count)
        expect(json['total_incomplete_tasks']).to eq(incomplete_tasks.count)
      end
    end
  end
end