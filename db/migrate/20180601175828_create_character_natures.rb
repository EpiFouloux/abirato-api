class CreateCharacterNatures < ActiveRecord::Migration[5.2]
  def change
    create_table :character_natures do |t|
      t.string :name, null: false
      t.text :description

      t.integer :power, null: false, limit: 1
      t.integer :control, null: false, limit: 1
      t.integer :swiftness, null: false, limit: 1

      t.integer :strength, null: false, limit: 1
      t.integer :consitution, null: false, limit: 1
      t.integer :dexterity, null: false, limit: 1
      t.integer :intelligence, null: false, limit: 1

      t.timestamps
    end
  end
end
