class InstructionsController < ApplicationController
    before_action :set_recipe
    before_action :set_recipe_instruction, only: [:show, :update, :destroy]
    def index
        @instructions = Instruction.all
        json_response(@instructions)
    end

    def show
        json_response(@instruction)
    end

    def create
        @recipe.instructions.create!(instruction_params)
        json_response(@recipe, :created)
    end

    def update
        @instruction.update(instruction_params)
        head :no_content
    end

    def destroy
        @instruction.destroy
        head :no_content
    end

    private
    def instruction_params
        params.permit(:step)
    end

    def set_recipe
        @recipe = Recipe.find(params['recipe_id'])
    end

    def set_recipe_instruction
        @instruction = @recipe.instructions.find(params['id']) if @recipe
    end
end
