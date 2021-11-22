require 'rails_helper'

RSpec.describe "Ingredients", type: :request do
  let!(:recipe) {create(:recipe)}
  let!(:ingredients) {create_list(:ingredient, 20, recipe_id: recipe.id)}
  let(:recipe_id) {recipe.id}
  let(:id) {ingredients.first.id}

  describe "GET /recipes/:recipe_id/ingredients" do
    before {get "/recipes/#{recipe_id}/ingredients" } 

    context 'if recipe exists' do
      it 'returns status code of 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all recipe ingredients' do
        expect(json.size).to eq(20)
      end
    end

    context 'if recipe does not exist' do
      let(:recipe_id) {0}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn\'t find Recipe/)
      end
    end
  end

  describe 'GET /recipes/:recipe_id/ingredients/:id' do
    before { get "/recipes/#{recipe_id}/ingredients/#{id}" }

    context 'if recipe ingredient exists' do
      it 'returns status code of 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns recipe ingredient' do
        expect(json['id']).to eq(id) 
      end
    end
    
    context 'if recipe ingredient does not exist' do
      let(:id) {0}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Ingredient/)
      end
    end
  end

  describe 'POST /recipes/:recipe_id/ingredients' do
    context 'if attributes are valid' do
      let(:valid_attributes) {{name: 'pepper'}}
      before { post "/recipes/#{recipe_id}/ingredients", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns recipe with that ingredient' do
        expect(json['name']).to eq(valid_attributes[:name])
      end
    end

    context 'if attributes are not valid' do
      before { post "/recipes/#{recipe_id}/ingredients", params: {} }

      it 'returns status code of 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns validation error' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /recipes/:recipe_id/ingredients/:id' do
    let(:valid_attributes) {{name: 'salt'}}
    before { put "/recipes/#{recipe_id}/ingredients/#{id}", params: valid_attributes }
     
    context 'if ingredient exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end   

      it 'updates the ingredient' do
        updated_ingredient = Ingredient.find(id)
        expect(updated_ingredient.name).to match(/salt/)
      end
    end

    context 'if ingredient does not exist' do
      let(:id) {0}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found response' do
        expect(response.body).to match(/Couldn't find Ingredient/)
      end
    end
  end

  describe 'DELETE /recipes/:recipe_id/ingredients/:id' do
    before { delete "/recipes/#{recipe_id}/ingredients/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'deletes ingredient' do
      deleted_ingredient = Ingredient.find_by(id: id)
      expect(deleted_ingredient).to be_nil
    end
  end
end
