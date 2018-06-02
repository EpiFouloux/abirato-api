class CreateCharacterInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :character_instances do |t|
      t.string :name, null: false

      t.integer :level, null: false, default: 0, limit: 1
      t.integer :experience_amount, null: false, default: 0

      t.integer :additive_power, null: false, default: 0, limit: 1
      t.integer :additive_swiftness, null: false, default: 0, limit: 1
      t.integer :additive_control, null: false, default: 0, limit: 1

      t.integer :additive_strength, null:false, default: 0, limit: 1
      t.integer :additive_constitution, null:false, default: 0, limit: 1
      t.integer :additive_dexterity, null:false, default: 0, limit: 1
      t.integer :additive_intelligence, null:false, default: 0, limit: 1

      t.decimal :grown_strength, null: false, default: 0.0
      t.decimal :grown_constitution, null: false, default: 0.0
      t.decimal :grown_dexterity, null: false, default: 0.0
      t.decimal :grown_intelligence, null: false, default: 0.0

      t.references :character_nature, foreign_key: true
      t.references :character_class, foreign_key: true
      t.references :character_template, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
