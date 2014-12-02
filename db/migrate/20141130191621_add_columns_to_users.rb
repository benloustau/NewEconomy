class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :text
    add_column :users, :offering, :text
  end
end
