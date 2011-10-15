class AddDescriptionToItems < ActiveRecord::Migration
  def change
    remove_column :items, :description
    add_column :items, :description, :text
  end
end
