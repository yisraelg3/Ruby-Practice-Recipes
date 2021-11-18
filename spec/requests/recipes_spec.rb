require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  let!(:recipes) {create_list(:recipe, 10)}
  let(:recipe_id) {recipes.first.id}

  describe "GET /recipes" do
    before {get '/recipes'}

    it 'returns recipes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /recipes/:id" do
    before {get "/recipes/#{recipe_id}"}

    context 'when the record exists' do
      it 'returns the recipe' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(recipe_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'When the record does not exist' do
      let(:recipe_id) {100}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end

  describe "POST /recipes" do
    let(:valid_attributes) {{name: 'cholent'}}

    context 'when the requst is valid' do
      before {post '/recipes', params: valid_attributes}

      it 'creates a recipe' do
        expect(json['name']).to eq('cholent')
      end

      it 'returns status code 201'  do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {post '/recipes', params: {name: ''}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe "PUT /recipes/:id" do
    let(:valid_attributes) {{name: 'Kugel'}}

    context 'when the record exists' do
      before {put "/recipes/#{recipe_id}", params: valid_attributes}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe "DELETE /recipes/:id" do
    before {delete "/recipes/#{recipe_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
