class CreateCharacterTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :character_templates do |t|
      t.string :name, null: false

      t.references :character_nature, foreign_key: true

      t.timestamps
    end
  end
end
