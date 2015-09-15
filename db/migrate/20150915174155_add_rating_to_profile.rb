class AddRatingToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :rating_number, :integer
    add_index :profiles, :rating_number, unique: true
  end
end
