class CreateCharacterEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :character_events do |t|
      t.datetime :event_date, null: false
      t.string :event_type, null: false
      t.text :event_data, null: false
      t.references :characters, index: true, null: false

      t.timestamps
    end
  end
end
