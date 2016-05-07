class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.string :title
      t.text :description
      t.references :board, index: true, foreign_key: true
      t.string :link

      t.timestamps null: false
    end
  end
end
