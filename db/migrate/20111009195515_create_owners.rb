class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
      
      
    end
    add_index :owners, :user_id
  end
end
