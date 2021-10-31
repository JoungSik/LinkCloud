class AddLinkDescription < ActiveRecord::Migration[6.1]
  def change
    add_column :links, :description, :text
  end
end
