class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.belongs_to :user, null: false
      t.string :name, null: false
      t.string :url, null: false

      t.timestamps
    end

    add_index :links, :name, unique: true
  end
end
