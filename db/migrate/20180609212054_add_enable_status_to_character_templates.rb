class AddEnableStatusToCharacterTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :character_templates, :description, :text
    add_column :character_templates, :enabled, :boolean, default: true
  end
end
