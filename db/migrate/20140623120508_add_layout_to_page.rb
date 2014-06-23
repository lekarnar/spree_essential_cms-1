class AddLayoutToPage < ActiveRecord::Migration
  def change
    add_column :spree_pages, :layout, :string
  end
end
