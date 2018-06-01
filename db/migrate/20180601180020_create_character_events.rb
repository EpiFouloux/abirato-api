class CreateCharacterEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :character_events do |t|
      t.datetime :event_date, null: false
      t.string :event_type, null: false
      t.text :event_data, null: false
      t.references :character_instance, foreign_key: true

      t.timestamps
    end
  end
end
