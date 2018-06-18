class AddWaitingTraitToCharacterInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :character_instances, :waiting_trait, :boolean, default: false
  end
end
