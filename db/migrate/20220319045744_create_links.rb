class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.string :url
      t.text :description

      t.timestamps
    end

    add_index :links, :name
  end
end
