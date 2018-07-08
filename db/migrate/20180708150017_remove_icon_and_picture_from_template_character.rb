class RemoveIconAndPictureFromTemplateCharacter < ActiveRecord::Migration[5.2]
  def change
    remove_column :character_templates, :icon_id
    remove_column :character_templates, :picture_id
  end
end
