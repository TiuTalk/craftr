class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes, id: :uuid do |t|
      t.belongs_to :item, foreign_key: true, type: :uuid
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
