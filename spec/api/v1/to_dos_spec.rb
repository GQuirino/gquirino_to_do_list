require 'rails_helper'

RSpec.describe 'Todo API', type: :request do
  def json_response
    JSON.parse(response.body)
  end

  let(:status) { :pending }
  let(:title) { "New Title" }
  let(:description) { "New Description" }
  let!(:to_do) { ToDo.create!(title:, status:, description:) }

  describe 'GET /api/v1/todos' do
    it 'returns a list of all ToDos' do
      get '/api/v1/todos'
      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Array)
      expect(json_response.size).to eq 1
    end
  end

  describe 'GET /api/v1/todos/:id' do
    context 'when item exists' do
      it 'returns the item' do
        get "/api/v1/todos/#{to_do.id}"
        expect(response).to have_http_status(:ok)
        expect(json_response['id']).to eq(to_do.id)
      end
    end

    context 'when the item does not exist' do
      it 'returns a not_found error' do
        get '/api/v1/todos/9999'
        expect(response).to have_http_status(:not_found)
        expect(json_response['error']).to eq('Not Found')
      end
    end
  end

  describe 'POST /api/v1/todos' do
    let(:params) { { title:, description:, status: } }

    context 'with valid params' do
      it 'creates a new item' do
        post('/api/v1/todos', params:)
        expect(response).to have_http_status(:created)
        expect(json_response['title']).to eq(title)
        expect(json_response['description']).to eq(description)
        expect(json_response['status']).to eq(status.to_s)
        expect do
          post '/api/v1/todos', params:
        end.to change(ToDo, :count).by(1)
      end
    end

    context 'with missing params' do
      params = { title: nil }
      it 'returns a bad request error' do
        post('/api/v1/todos', params:)
        expect(response).to have_http_status(:bad_request)
        expect do
          post '/api/v1/todos', params:
        end.not_to change(ToDo, :count)
      end
    end
  end
end
