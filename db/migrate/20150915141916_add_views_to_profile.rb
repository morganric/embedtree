class AddViewsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :views, :integer
  end
end
