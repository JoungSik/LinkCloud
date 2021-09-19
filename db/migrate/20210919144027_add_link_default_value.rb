class AddLinkDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column :links, :name, :string, default: ""
    change_column :links, :url, :string, default: ""
  end
end
