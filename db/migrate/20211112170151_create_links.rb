class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.text :url

      t.timestamps
    end
  end
end
