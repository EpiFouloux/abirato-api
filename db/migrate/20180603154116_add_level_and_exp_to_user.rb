class AddLevelAndExpToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :level, :integer, null: false, default: 0
    add_column :users, :experience_amount, :integer, null: false, default: 0
  end
end
