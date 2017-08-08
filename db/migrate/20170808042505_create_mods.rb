class CreateMods < ActiveRecord::Migration[5.1]
  def change
    create_table :mods, id: :uuid do |t|
      t.string :name
      t.string :version

      t.timestamps
    end
  end
end
