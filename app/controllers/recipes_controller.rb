class RecipesController < ApplicationController
    before_action :set_recipe, only: [:show, :update, :destroy]
    def index
        @recipes = Recipe.all
        json_response(@recipes)
    end

    def create
        @recipe = Recipe.create!(recipe_params)
        json_response(@recipe, :created)
    end

    def show
        json_response(@recipe)
    end

    def update
        @recipe.update(recipe_params)
        head :no_content
    end

    def destroy
        @recipe.destroy
        head :no_content
    end

    private
    def recipe_params
        params.permit(:name)
    end
    
    def set_recipe
        @recipe = Recipe.find(params['id'])
    end
end
