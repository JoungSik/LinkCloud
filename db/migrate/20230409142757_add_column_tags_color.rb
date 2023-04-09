class AddColumnTagsColor < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :color, :string, after: :name, default: "#616A71"
  end
end
