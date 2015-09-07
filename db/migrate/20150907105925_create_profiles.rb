class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :display_name
      t.text :bio
      t.string :image
      t.integer :user_id
      t.string :slug
      t.string :website

      t.timestamps null: false
    end
    add_index :profiles, :user_id, unique: true
  end
end
