class CreateInstructions < ActiveRecord::Migration[6.1]
  def change
    create_table :instructions do |t|
      t.string :step
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
