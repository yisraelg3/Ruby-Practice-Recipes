class IngredientsController < ApplicationController
    before_action :set_recipe
    before_action :set_recipe_ingredient, only: [:show, :update, :destroy]

    def index
        @ingredients = @recipe.ingredients
        json_response(@ingredients)
    end

    def show
        json_response(@ingredient)
    end

    def create
        ingredient = @recipe.ingredients.create!(ingredient_params)
        json_response(ingredient, :created)
    end

    def update
        @ingredient.update(ingredient_params)
        head :no_content
    end

    def destroy
        @ingredient.destroy
        head :no_content
    end

    private
    def ingredient_params
        params.permit(:name)
    end

    def set_recipe
        @recipe = Recipe.find(params['recipe_id'])
    end
    
    def set_recipe_ingredient
        @ingredient = @recipe.ingredients.find(params['id'])
    end
end
