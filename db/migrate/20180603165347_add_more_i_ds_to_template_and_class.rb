class AddMoreIDsToTemplateAndClass < ActiveRecord::Migration[5.2]
  def change
    add_column :character_templates, :icon_id, :integer
    add_column :character_templates, :picture_id, :integer
    add_column :character_templates, :model_id, :integer
    add_column :character_templates, :skill_one_id, :integer
    add_column :character_templates, :skill_two_id, :integer
    add_column :character_templates, :skill_three_id, :integer


    add_column :character_classes, :skill_id, :integer
  end
end
