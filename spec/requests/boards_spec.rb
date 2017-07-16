require 'rails_helper'

RSpec.describe 'Boards API', type: :request do
  # initialize test data 
  let!(:boards) { create_list(:board, 10) }
  let(:board_id) { boards.first.id }

  # Test suite for GET /boards
  describe 'GET /boards' do
    # make HTTP get request before each example
    before { get '/boards' }

    it 'returns boards' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /boards/:id
  describe 'GET /boards/:id' do
    before { get "/boards/#{board_id}" }

    context 'when the record exists' do
      it 'returns the board' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(board_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:board_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Board/)
      end
    end
  end

  # Test suite for POST /boards
  describe 'POST /boards' do
    # valid payload
    let(:valid_attributes) { { title: 'Title of board', description: 'Description of board' } }

    context 'when the request is valid' do
      before { post '/boards', valid_attributes }

      it 'creates a board' do
        expect(json['title']).to eq('Title of board')
        expect(json['description']).to eq('Description of board')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for PUT /boards/:id
  describe 'PUT /boards/:id' do
    let(:valid_attributes) { { title: Faker::Lorem.word, description: Faker::Lorem.word } }

    context 'when the record exists' do
      before { put "/boards/#{board_id}", valid_attributes }

      it 'updates the record' do
        expect(json['title']).to eq(valid_attributes[:title])
        expect(json['description']).to eq(valid_attributes[:description])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /boards/:id
  describe 'DELETE /boards/:id' do
    before { delete "/boards/#{board_id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end