class AddLinksFromTables < ActiveRecord::Migration[5.2]
  def change
  	add_reference :characters, :natures, index: true
  	add_reference :characters, :character_classes, index: true
  	add_reference :characters, :template_characters, index: true
  	add_reference :characters, :users, index: true

  	add_reference :template_characters, :natures, index: true
  end
end
