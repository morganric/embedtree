class AddViewsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :views, :integer, default: 0
  end
end
