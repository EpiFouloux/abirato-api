class AddMoreSkillsToCharacterInstance < ActiveRecord::Migration[5.2]
  def change
    rename_column :character_instances, :character_class_id, :character_special_class_id
    add_reference :character_instances, :character_prestigious_class, foreign_key:  { to_table: :character_classes }
    add_reference :character_instances, :character_legendary_class, foreign_key: { to_table: :character_classes }
  end
end
