class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.string :title
      t.string :image
      t.string :thumbnail
      t.text :embed_code
      t.text :description
      t.string :author
      t.string :author_url
      t.string :provider
      t.string :provider_url
      t.boolean :hidden
      t.boolean :featured
      t.integer :user_id
      t.integer :views
      t.string :slug
      t.string :tag_list

      t.timestamps null: false
    end
  end
end
