class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients, id: :uuid do |t|
      t.belongs_to :recipe, foreign_key: true, type: :uuid
      t.belongs_to :item, foreign_key: true, type: :uuid
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
