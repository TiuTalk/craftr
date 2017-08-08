class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items, id: :uuid do |t|
      t.belongs_to :mod, foreign_key: true, type: :uuid
      t.string :name
      t.string :identifier
      t.string :icon

      t.timestamps
    end

    add_index :items, :identifier
  end
end
