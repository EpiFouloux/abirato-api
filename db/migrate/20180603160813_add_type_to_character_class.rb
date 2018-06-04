class AddTypeToCharacterClass < ActiveRecord::Migration[5.2]
  def change
    add_column :character_classes, :class_type, :integer, null: false
  end
end
