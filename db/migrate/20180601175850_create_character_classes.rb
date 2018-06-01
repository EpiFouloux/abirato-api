class CreateCharacterClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :character_classes do |t|
      t.integer :power, null: false, limit: 1
      t.integer :control, null: false, limit: 1
      t.integer :swiftness, null: false, limit: 1
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
